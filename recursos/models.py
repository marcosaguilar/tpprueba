from administracion.models import Usuario
from django.db import models
from django.db.models import Q
from datetime import date, timedelta



class TipoRecurso(models.Model):
    """Clase que representa un tiporecurso, agrupa recursos similares para identificarlos mejor"""
    nombre = models.CharField(max_length=32, unique=True, null=False)
    descripcion_defecto = models.TextField(max_length=1000, verbose_name='Descripcion')

    def __str__(self):
        return self.nombre

class Recurso(models.Model):
    """Clase para la definicion de Recursos"""
    codigo = models.CharField(max_length=10, unique=True, blank=False)
    tipo = models.ForeignKey(TipoRecurso)
    disponible = models.BooleanField(default=True)
    caracteristica = models.TextField(max_length=1000)
    dias_vida_util = models.IntegerField(verbose_name='Vida util (dias)', default=1000, null=False)
    ultimo_mantenimiento = models.DateField(default=None, null=True)
    administrador = models.ForeignKey(Usuario,verbose_name="Administrador de recurso",null=True,limit_choices_to= Q( groups__name = 'Administrador de Recursos') )
    fecha_creacion = models.DateField(auto_now_add=True)
    averiado = models.BooleanField(default=False)
    def _get_siguiente_mantenimiento(self):
        if self.ultimo_mantenimiento != None:
            return self.ultimo_mantenimiento + timedelta(days=self.dias_vida_util)
        return self.fecha_creacion + timedelta(days=self.dias_vida_util)
    siguiente_mantenimiento = property(_get_siguiente_mantenimiento)

    def _pendiente_de_mantenimiento(self):
        if self.ultimo_mantenimiento == None:
            return self.fecha_creacion + timedelta(days=self.dias_vida_util) >= date.today()
        else:
            return self.siguiente_mantenimiento >= date.today()
    pendiente_de_mantenimiento = property(_pendiente_de_mantenimiento)

    def __str__(self):
        return self.tipo.nombre + ' ' + self.codigo
    class Meta:
       ordering = ['tipo','codigo']