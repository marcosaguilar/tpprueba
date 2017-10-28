from django.db import models
from django.contrib.auth.models import User,AbstractUser,Group

class Rango(models.Model):
    """Clase que representa al Rango del usuario en el sistema"""
    prioridad = models.FloatField(unique= True, null=False)
    nombre = models.CharField(max_length=30, null= False)
    def __str__(self):
        return self.nombre

class Usuario(AbstractUser, models.Model):
    """Clase que representa a un usuario en el sistema"""
    ci = models.CharField(max_length=15, unique=True, blank=False, verbose_name = 'Cedula de identidad')
    rango = models.ForeignKey(Rango, null=True, blank=True)
    penalizacion = models.FloatField(default = 0)
    def clean(self):
        # Todos los usuarios tienen acceso a /admin, aunque para los solicitantes es solo una pagina vacia.
        self.is_staff = True

