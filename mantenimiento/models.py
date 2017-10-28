from django.db import models
from recursos.models import Recurso

class Mantenimiento(models.Model):
    '''Clase que representa al Mantenimiento dentro del sistema'''
    TIPO_MANTENIMIENTO = (
        ('0', 'Preventivo'),
        ('1', 'Correctivo'),
    )
    ESTADOS = (
        ('0', 'Pendiente'),
        ('1', 'En Mantenimiento'),
    )

    recurso = models.ForeignKey(Recurso,null=False, unique=True)
    detalle = models.TextField(max_length=1000,null=False)
    tipo = models.CharField(max_length=1,choices=TIPO_MANTENIMIENTO,null=False)
    estado = models.CharField(max_length=1,choices=ESTADOS,null=False,default=0)