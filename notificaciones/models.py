from django.db import models
from django.dispatch import receiver
from django.db.models.signals import post_save, post_delete
from django.core.mail import send_mail
from administracion.models import Usuario

class notificacion(models.Model):
    '''Clase que sirve para guardar en la base de datos las notificaciones'''
    titulo = models.CharField(max_length=40)
    texto = models.TextField(max_length=250)

@receiver(post_save,sender= Usuario)
def notificacion_solicitud_handler(sender,instance,created,update_fields,**kwargs):
    '''Metodo que maneja la señal Post_Save para notificar las solicitudes aceptadas'''
    if created == False and update_fields!= None and 'is_active' in update_fields and instance.is_active == True:
        userEmail = instance.email
        plantilla = notificacion.objects.get(titulo= "Solicitud Aceptada")
        message = plantilla.texto
        subject = plantilla.titulo
        send_mail(subject,message,"teamsgr17@gmail.com",[userEmail])

@receiver(post_delete,sender = Usuario)
def solicitud_rechazada_handler(sender,instance,**kwargs):
    '''Metodo que maneja la señal Post_Delete para notificar las solicitudes rechazadas'''
    if instance.is_active == False:
        userEmail = instance.email
        plantilla = notificacion.objects.get(titulo="Solicitud Rechazada")
        message = plantilla.texto
        subject = plantilla.titulo
        send_mail(subject, message, "teamsgr17@gmail.com", [userEmail])