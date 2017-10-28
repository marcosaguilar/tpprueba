from ast import literal_eval

from django.contrib import admin, messages
from .models import Reserva, MiReserva, ControlReserva, ColaDePrioridades
from datetime import datetime, time, date, timedelta
from .models import Horas_catedras
from administracion.models import Usuario
from notificaciones.models import notificacion
from django.core.mail import send_mail


def cancelar_mireserva(mireserva, request, queryset):
    queryset.update(estado='4')
    for obj in queryset:
        control = ControlReserva.objects.get(reserva=obj)
        control.estado = '2'
        control.save()


cancelar_mireserva.short_description = "Cancelar reservas seleccionadas"

class ReservaAdmin(admin.ModelAdmin):
    '''Clase que representa al model Admin en Reservas, utilizado para definir
        que campos seran visibles/editables dependiendo del tipo de usuario'''
    exclude = ['responsable', 'estado', 'posicion', 'tipo']
    list_display = ['recurso', 'fecha', 'hora_inicio', 'tipo', 'posicion', 'estado']
    list_display_links = None
    actions = [cancelar_mireserva]

    def get_queryset(self, request):
        super(ReservaAdmin, self).get_queryset(request)
        return Reserva.objects.filter(responsable=request.user)

    def save_model(self, request, obj, form, change):
        obj.responsable = request.user
        obj.tipo = '1'
        obj.save()
        control = ControlReserva.objects.create(reserva=obj, estado='0')
        control.save()
        if(ColaDePrioridades.objects.filter(fecha=obj.fecha, recurso=obj.recurso, hora_catedra=obj.hora_inicio).count() == 0):
            cola = ColaDePrioridades.objects.create(fecha=obj.fecha, recurso=obj.recurso, hora_catedra=obj.hora_inicio, cola=[obj.id].__str__())
            cola.save()
            obj.posicion = 1
        else:
            cola = ColaDePrioridades.objects.get(fecha=obj.fecha, recurso=obj.recurso, hora_catedra=obj.hora_inicio)
            colaArray = literal_eval(cola.cola)
            usuarioCabeza = Reserva.objects.get(id=obj.id).responsable
            if obj.responsable.rango.prioridad + obj.responsable.penalizacion > usuarioCabeza.rango.prioridad + usuarioCabeza.penalizacion:
                obj.posicion=len(colaArray) + 1
                colaArray.append(obj.id)
            else:
                obj.posicion = 1
                colaArray.append(colaArray[0])
                colaArray[0] = obj.id

            cola.cola = colaArray.__str__()
            cola.save()
        obj.save()



@admin.register(ControlReserva)
class ControlReservaAdmin(admin.ModelAdmin):
    '''Clase que representa al model Admin en Control Reserva, utilizado para definir
    que campos seran visibles/editables dependiendo del tipo de usuario'''
    list_display = ('get_recurso','get_usuario','get_fecha', 'get_hora_ini','get_hora_fin','estado')
    exclude = ['reserva', 'estado']
    actions = ['entregar_equipo','finalizar_reserva']
    list_filter = ('estado',)
    def get_recurso(self,obj):
        '''Metodo para obtener el recurso'''
        return obj.reserva.recurso
    get_recurso.short_description = 'Recurso'

    def get_fecha(self, obj):
        '''Metodo para obtener la fecha'''
        return obj.reserva.fecha
    get_fecha.short_description = 'Fecha'

    def get_hora_ini(self, obj):
        '''Metodo para obtener la hora inicio'''
        return Horas_catedras[obj.reserva.hora_inicio][1]
    get_hora_ini.short_description = 'Hora Inicio'

    def get_hora_fin(self, obj):
        '''Metodo para obtener la hora fin'''
        return Horas_catedras[obj.reserva.hora_fin][1]
    get_hora_fin.short_description = 'Hora Fin'

    def get_usuario(self,obj):
        '''Metodo para obtener el solicitante'''
        return obj.reserva.responsable
    get_usuario.short_description = 'Solicitante'


    def entregar_equipo(self, request, queryset):
        '''Metodo que cambia el estado de una reserva'''
        if '2' in queryset.values_list('estado', flat= True)or '1' in queryset.values_list('estado', flat= True):
            mensaje = "No se puede entregar equipo en una reserva que no esta en espera"
            self.message_user(request, mensaje, level=messages.ERROR)
            return
        reserva = queryset.values_list('reserva_id', flat=True)

        for id in reserva:
            res = res = Reserva.objects.get(id=id)
            hora_inicio = int(Horas_catedras[res.hora_inicio][1][0] + Horas_catedras[res.hora_inicio][1][1])
            current = datetime.now() - timedelta(hours=4)
            if date.today() < res.fecha or current.hour < hora_inicio:
                mensaje = "No se puede entregar un equipo en fechas u horas previas a la reserva"
                self.message_user(request, mensaje, level=messages.ERROR)
                return

        filas = queryset.update(estado=1)
        if filas == 1:
             mensaje = "1 equipo entregado"
        else:
             mensaje = "%s equipos entregados" % filas
        self.message_user(request, mensaje)


    def finalizar_reserva(self, request, queryset):
        '''Metodo que cambia el estado de una reserva'''
        if '2' in queryset.values_list('estado', flat= True) or '0' in queryset.values_list('estado', flat= True):
            mensaje = "No se puede finalizar una reserva que no esta en ejecucion"
            self.message_user(request, mensaje, level=messages.ERROR)
            return
        filas = queryset.update(estado=2)
        if filas == 1:
            mensaje = "1 reserva finalizada"
        else:
            mensaje = "%s reservas finalizadas" % filas
        reserva = queryset.values_list('reserva_id', flat=True)
        for id in reserva:
            res = Reserva.objects.get(id=id)
            res.estado = 3
            res.save()
            hora_fin = int(Horas_catedras[res.hora_fin][1][0] + Horas_catedras[res.hora_fin][1][1])
            current = datetime.now() - timedelta(hours=4)
            usuario = Usuario.objects.get(id = res.responsable.id)
            if date.today() > res.fecha:
                usuario.penalizacion = usuario.penalizacion + 0.2
                usuario.save()
            elif current.hour > hora_fin:
                usuario.penalizacion = usuario.penalizacion + 0.1
                usuario.save()
            else:
                if(usuario.penalizacion > 0):
                    usuario.penalizacion = usuario.penalizacion - 0.2
                    usuario.save()
            self.enviar_correo(usuario, res.recurso)
        self.message_user(request, mensaje)

    def enviar_correo(self, solicitante, recurso):
        '''Metodo utilizado para enviar el correo electronico al solicitante'''
        email = solicitante.email
        subject = notificacion.objects.get(titulo="Finalizacion Reserva").titulo
        message = notificacion.objects.get(titulo="Finalizacion Reserva").texto + \
                  "\nSolicitante: " + solicitante.first_name + " " + solicitante.last_name + \
                  "\nRecurso: " + recurso.__str__() + \
                  "\nFecha de entrega: " + str(date.today()) + \
                  "\nHora de entrega :" + str(datetime.now() - timedelta(hours=4)) + "\n"
        send_mail(subject, message, "teamsgr17@gmail.com", [email])


# Register your models here.
admin.site.register(Reserva)
admin.site.register(MiReserva, ReservaAdmin)

