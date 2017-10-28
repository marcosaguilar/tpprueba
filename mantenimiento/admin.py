from django.contrib import admin
from reservas.models import Reserva
from .models import Mantenimiento
from recursos.models import Recurso
from notificaciones.models import notificacion
from datetime import date
from django.core.mail import send_mail
from reservas.models import ControlReserva, Horas_catedras
@admin.register(Mantenimiento)
class MantenimientoAdmin(admin.ModelAdmin):
    '''Clase que representa al model Admin en Mantenimiento, utilizado para definir
    que campos seran visibles/editables dependiendo del tipo de usuario'''
    list_display = ('recurso','detalle', 'tipo','estado','get_ultimo_mantenimiento')
    list_filter = ('tipo',)
    exclude = ['estado']
    actions = ['realizar_mantenimiento','finalizar_mantenimiento']
    def get_ultimo_mantenimiento(self,obj):
        '''Metodo utilizado para obtener la fecha del ultimo mantenimiento'''
        return obj.recurso.ultimo_mantenimiento

    get_ultimo_mantenimiento.short_description = 'Ultimo Mantenimiento'

    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == "recurso":
            kwargs["queryset"] = Recurso.objects.filter(administrador=request.user, disponible=True)
        return super(MantenimientoAdmin, self).formfield_for_foreignkey(db_field, request, **kwargs)

    def get_queryset(self,request):
        '''Se sobrescribe el metodo get_queryset para filtrar de acuerdo al tipo de usuario'''
        super(MantenimientoAdmin,self).get_queryset(request)
        roles = request.user.groups.values_list('name', flat=True)
        if request.user.is_superuser or "Administrador General" in roles :
            return Mantenimiento.objects.all()
        return Mantenimiento.objects.filter(recurso__administrador=request.user)

    def realizar_mantenimiento(self, request, queryset):
        '''Metodo que cambia el estado de mantenimiento y estado de un recurso en caso que este disponible'''
        filas = queryset.update(estado=1)
        recurso = queryset.values_list('recurso_id',flat=True)
        for id in recurso:
            Recurso.objects.filter(pk=id).update(disponible=False)
            reservas = Reserva.objects.all().values_list('recurso',flat=True).distinct()
            if id in reservas:
                reservas_rec=Reserva.objects.filter(recurso=id)
                for res in reservas_rec:
                    try:
                        ControlReserva.objects.get(reserva_id=res.pk).delete()
                        email = request.user.email
                        subject = notificacion.objects.get(titulo="Reserva Cancelada por Mantenimiento").titulo
                        message = notificacion.objects.get(titulo="Reserva Cancelada por Mantenimiento").texto + \
                        "\nRecurso: " + Recurso.objects.get(pk=id).__str__() + \
                        "\nFecha: " + str(res.fecha) + \
                        "\nHora Inicio :" + Horas_catedras[res.hora_inicio][1] + \
                        "\nHora Fin: " + Horas_catedras[res.hora_fin][1] + "\n"
                        send_mail(subject, message, "teamsgr17@gmail.com", [email])
                        res.delete()
                    except:
                        pass
        if filas == 1:
            mensaje="1 equipo llevado"
        else:
            mensaje = "%s equipos llevados" % filas
        self.message_user(request,"%s para mantenimiento" % mensaje)

    def finalizar_mantenimiento(self,request,queryset):
        '''Metodo que cambia el estado de un recurso a disponible, y lo saca de la lista de mantenimiento'''
        recurso = queryset.values_list('recurso_id', flat=True)
        for id in recurso:
            Recurso.objects.get(pk=id)._get_siguiente_mantenimiento()
            Recurso.objects.filter(pk=id).update(disponible=True,ultimo_mantenimiento=date.today())
        filas = queryset.delete()
        if filas[0] == 1:
            mensaje="1 equipo ha"
        else:
            mensaje = "%s equipos han" % filas[0]
        self.message_user(request,"%s finalizado su mantenimiento" % mensaje)
