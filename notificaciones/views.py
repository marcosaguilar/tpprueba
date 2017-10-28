from django.views.generic import ListView, UpdateView
from .models import notificacion
from .forms import notificarAveriadoForm
from django.core.mail import send_mail
from django.shortcuts import render
from recursos.models import Recurso
from reservas.models import Reserva,Horas_catedras,ControlReserva
from administracion.models import Usuario
from mantenimiento.models import Mantenimiento

class listar_notificaciones(ListView):
    '''Vista que se utiliza para listar las notificaciones'''
    model = notificacion
    template_name = 'notificaciones/listarNotificaciones.html'

class configurar_notificaciones(UpdateView):
    '''Vista que se utiliza para configurar las notificaciones'''
    model = notificacion
    fields = ['texto']
    template_name = 'notificaciones/configurarNotificaciones.html'
    success_url = '/notificaciones/listarNotificaciones'

def notificar_recurso_averiado(request):
    '''Vista que se utiliza para buscar recursos para notificarlos como averiados'''
    if request.method == "POST":
        form = notificarAveriadoForm(request.POST)
        if form.is_valid():
            codigo = form.cleaned_data['codigo']
            try:
                recurso = Recurso.objects.get(codigo=codigo)
                grupo = request.user.groups.values_list('name', flat = True)
                if (request.user == recurso.administrador or 'Administrador General' in grupo):
                    return render(request, 'notificaciones/notificarEquipoAveriado.html', {'recurso': recurso})
                return render(request,'notificaciones/notificarEquipoAveriado.html', {'mensaje': 'El recurso con el codigo ' + codigo + ' esta asignado a otro administrador.'})

            except:
                return render(request,'notificaciones/notificarEquipoAveriado.html', {'mensaje': 'El recurso con el codigo ' + codigo + ' no existe'})
    else:
        form = notificarAveriadoForm(initial={'key': 'value'})

    return render(request, 'notificaciones/buscarEquipoAveriado.html', {'form': form})

def notificacion_correcta(request):
    '''Vista que se utiliza para notificar un recurso como averiado al administrador de recursos que le corresponde'''
    if "notificar" in request.POST:
        codigo = request.POST['codigo']
        adminEmail = Usuario.objects.all().filter(groups__name='Administrador General').values_list('email',flat=True)
        email = adminEmail[0]
        noti = notificacion.objects.get(titulo="Equipo Averiado")
        recurso = Recurso.objects.get(codigo = codigo)
        recurso.averiado = True
        recurso.save()
        reservas = Reserva.objects.all().values_list('recurso', flat=True).distinct()
        if recurso.pk in reservas:
            reservas_rec = Reserva.objects.filter(recurso=recurso.pk)
            for res in reservas_rec:
                try:
                    ControlReserva.objects.get(reserva_id=res.pk).delete()
                    email = request.user.email
                    subject = notificacion.objects.get(titulo="Reserva Cancelada por Equipo averiado").titulo
                    message = notificacion.objects.get(titulo="Reserva Cancelada por Equipo averiado").texto + \
                          "\nRecurso: " + Recurso.objects.get(pk=recurso.pk).__str__() + \
                          "\nFecha: " + str(res.fecha) + \
                          "\nHora Inicio :" + Horas_catedras[res.hora_inicio][1] + \
                          "\nHora Fin: " + Horas_catedras[res.hora_fin][1] + "\n"
                    send_mail(subject, message, "teamsgr17@gmail.com", [email])
                    res.delete()
                except:
                    pass
        mantenimiento = Mantenimiento.objects.get(recurso = recurso)
        mantenimiento.delete()
        admRecurso = recurso.administrador.first_name + " " + recurso.administrador.last_name
        subject = noti.titulo
        mensaje = " Codigo de Recurso: "+ codigo  + "\n" + noti.texto + "\n\n" + "El administrador de recursos a cargo fue:" + admRecurso
        send_mail(subject, mensaje, "teamsgr17@gmail.com", [email])
        return render(request, 'notificaciones/notificarEquipoAveriado.html',{'mensaje': 'Se notificacion fue enviada correctamente'})

def notificar_mantenimiento_correctivo(request):
    '''Vista que se utiliza para buscar recursos para notificarlos en mantenimiento correctivo '''
    if request.method == "POST":
        form = notificarAveriadoForm(request.POST)
        if form.is_valid():
            codigo = form.cleaned_data['codigo']
            try:
                recurso = Recurso.objects.get(codigo=codigo)
                return render(request, 'notificaciones/enviarNotiMantenimientoCorrectivo.html', {'recurso': recurso})
            except:
                return render(request,'notificaciones/notificarMantenimientoCorrectivo.html', {'mensaje': 'El recurso con el codigo ' + codigo + ' no existe'})
    else:
        form = notificarAveriadoForm(initial={'key': 'value'})

    return render(request, 'notificaciones/notificarMantenimientoCorrectivo.html', {'form': form})

def enviar_mantenimiento_correctivo(request):
    '''Vista que se utiliza para guardar y enviar la notificacion del mantenimiento correctivo de un recurso'''
    if "notificar" in request.POST:
        codigo = request.POST['codigo']
        detalle = request.POST['detalle']
        noti = notificacion.objects.get(titulo="Mantenimiento Correctivo")
        recurso = Recurso.objects.get(codigo=codigo)
        email = recurso.administrador.email
        admRecurso = recurso.administrador.first_name + " " + recurso.administrador.last_name
        subject = noti.titulo
        mensaje = noti.texto + " Codigo de Recurso: " + codigo + "\n" + "\n\n" + "El administrador de recursos a cargo fue:" + admRecurso
        try:
            if (recurso.disponible==True):
                recurso.disponible=False
                recurso.save()
            mantenimiento = Mantenimiento.objects.create(detalle = detalle, tipo = 1, recurso = recurso)
            mantenimiento.save()
            send_mail(subject, mensaje, "teamsgr17@gmail.com", [email])
            return render(request, 'notificaciones/enviarNotiMantenimientoCorrectivo.html',
                          {'mensaje': 'Su notificacion fue enviada correctamente'})
        except:
            return render(request, 'notificaciones/enviarNotiMantenimientoCorrectivo.html',
                      {'mensaje': 'Ese recurso ya se encuentra en mantenimiento'})