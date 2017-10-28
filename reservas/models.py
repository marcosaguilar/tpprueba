from django.db import models
from recursos.models import Recurso
from administracion.models import Usuario
import datetime

Horas_catedras=(
    (0,'07:30 AM'),
    (1,'08:15 AM'),
    (2,'09:00 AM'),
    (3,'09:45 AM'),
    (4,'10:30 AM'),
    (5,'11:15 PM'),
    (6,'12:00 PM'),
    (7,'12:45 PM'),
    (8,'13:15 PM'),
    (9,'14:00 PM'),
    (10,'14:45 PM'),
    (11,'15:30 PM'),
    (12,'16:15 PM'),
    (13,'17:00 PM'),
    (14,'17:45 PM'),
    (15,'18:30 PM'),
    (16,'19:15 PM'),
    (17,'20:00 PM'),
    (18,'20:45 PM'),
)

class Reserva(models.Model):
    '''Clase que representa a la Reserva dentro del sistema'''
    Tipo_Reserva = (
        ('0', 'Por disponibilidad'),
        ('1', 'Por recurso específico'),
    )
    Estado_Reserva=(
        ('0', 'En Espera'),                 # Recurso todavia no ha sido adjudicado
        ('1', 'Aprobado'),                  # Recurso ha sido adjudicado a esta reserva
        ('2', 'Rechazado'),                 # Recurso ha sido adjudicado a otra reserva
        ('3', 'Finalizado'),
        ('4', 'Cancelado')
    )
    fecha = models.DateField()
    hora_inicio = models.IntegerField(choices=Horas_catedras,null=False)
    hora_fin = models.IntegerField(choices=Horas_catedras,null=False)
    recurso = models.ForeignKey(Recurso, null=False)
    tipo = models.CharField(max_length=1, choices=Tipo_Reserva, null=False)
    estado = models.CharField(max_length=1, choices=Estado_Reserva, default='0')
    responsable = models.ForeignKey(Usuario)
    posicion = models.IntegerField(verbose_name='posicion en cola de espera', default=1)
    def __str__(self):
        return self.recurso.__str__() + ' para ' + self.responsable.__str__()

class MiReserva(Reserva):
    '''Clase proxy que representa las reservas desde el punto de vista del solicitante'''
    class Meta:
        proxy = True
        verbose_name = 'mi reserva'
        verbose_name_plural = 'mis reservas'

    def __str__(self):
        return self.recurso.__str__() + ' para fecha: ' + self.fecha.isoformat()

class ColaDePrioridades(models.Model):
    '''Cola de prioridades para reservas'''
    fecha=models.DateField()
    recurso=models.ForeignKey(Recurso)
    hora_catedra=models.IntegerField(choices=Horas_catedras)
    cola=models.CharField(max_length=255)           # cola va alvergar una cadena que representa un array de enteros
                                                    # donde los enteros son ids de reserva
class ControlReserva(models.Model):
    reserva = models.ForeignKey(Reserva)
    Estado_Reserva = (
        ('0', 'En espera'),  # Recurso todavia no ha sido entregado
        ('1', 'En ejecucion'),  # Recurso se entrego
        ('2', 'Finalizado'),  # Recurso se devolvio
    )
    estado = models.CharField(max_length=1, choices=Estado_Reserva, default='0')
    obs = models.CharField(max_length=300)

    def __str__(self):
        return str(self.reserva.id)
