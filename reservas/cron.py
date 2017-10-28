# Cada dia, este proceso revisa las reservas y adjudica aquellas para las que faltan dos dias.
# La reserva se adjudica basada en el rango del solicitante,
# cantidad de dias de antelacion, penalizaciones diversas, etc.
from django.core.mail import send_mail

from reservas.models import Reserva, ControlReserva
from datetime import date, timedelta


def notificar_adjudicacion(reserva):
    try:
        subject = "Reserva adjudicada"
        message = "Su reserva de " + reserva.recurso.__str__() + ' para el dia ' + reserva.fecha.isoformat() + 'fue aprobada.'
        address = reserva.responsable.email
        send_mail(subject, message, "teamsgr17@gmail.com", [address])
    except:
        '''No se pudo enviar notificacion de reserva'''
        pass


def notificar_rechazo(reserva):
    try:
        subject = "Reserva rechazada"
        message = "Su reserva de " + reserva.recurso.__str__() + ' para el dia ' + reserva.fecha.isoformat() + 'fue rechazada.'
        address = reserva.responsable.email
        send_mail(subject, message, "teamsgr17@gmail.com", [address])
    except:
        '''No se pudo enviar notificacion de reserva'''
        pass

def adjudicar_reservas():
    reservas = Reserva.objects.filter(estado='2', fecha=date.today() + timedelta(days=2))
    for reserva in reservas:
        if reserva.posicion == 1:
            reserva.estado = '1'
            notificar_adjudicacion(reserva)
        else:
            reserva.estado = '2'
            control = ControlReserva.objects.get(reserva=reserva)
            control.estado='2'
            control.save()
            notificar_rechazo(reserva)
        reserva.save()

