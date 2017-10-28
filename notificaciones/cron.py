from recursos.models import Recurso
from django.core.mail import send_mail
from notificaciones.models import notificacion
from datetime import date,timedelta,datetime
from mantenimiento.models import Mantenimiento

def verificar_vida_util():
    '''Metodo que se encarga de Verificar la vida util de un Recurso y Notificar al administrador correspondiente'''
    recursos = Recurso.objects.all()
    for recurso in recursos:
        if recurso.ultimo_mantenimiento == None:
            vida_util= date.today() + timedelta(days=recurso.dias_vida_util)
        else:
            vida_util=recurso.ultimo_mantenimiento + timedelta(days=recurso.dias_vida_util)
        if vida_util == date.today():
            adminEmail=recurso.administrador.email
            noti = notificacion.objects.get(titulo="Mantenimiento Preventivo")
            subject = noti.titulo
            mensaje = " Codigo de Recurso: "+ recurso.codigo + "\n" + noti.texto
            #se registra en un log la notificacion
            print(str(datetime.today()) + " " +recurso.codigo + " " + adminEmail + " Notificacion Mantenimiento Preventivo")
            try:
                mantenimiento = Mantenimiento.objects.create(detalle="Tiempo de vida util alcanzada", tipo=0, recurso=recurso)
                mantenimiento.save()
                send_mail(subject, mensaje, "teamsgr17@gmail.com", [adminEmail])
            except:
                '''No se crea el mantenimiento porque ya se encuentra en ello'''
                pass