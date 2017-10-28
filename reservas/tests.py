from django.test import TestCase,Client
from administracion.models import Usuario
from .models import Reserva
from recursos.models import Recurso, TipoRecurso
from datetime import date
# Create your tests here.
class testReservaDisponibilidad(TestCase):
    def setUp(self):
        self.client = Client()
        Usuario.objects.create(username='Juan')
        TipoRecurso.objects.create(nombre="Proyector", descripcion_defecto="Esto es un Proyector")
        Recurso.objects.create(codigo='123', tipo=TipoRecurso.objects.get(nombre="Proyector"), disponible=True,
                               caracteristica="Esto es una Equipo", dias_vida_util=1000,
                               ultimo_mantenimiento=date.today())
        Reserva.objects.create(id = '1',fecha='2017-06-05', hora_inicio= 1, hora_fin = 2, recurso = Recurso.objects.get(codigo = '123'), tipo = 0, estado = 1, responsable = Usuario.objects.get(username='Juan'), posicion = 1)

    def test_creacion(self):
        lista_disponibilidad = Reserva.objects.all().filter(tipo=0)
        reserva = Reserva.objects.get(recurso__codigo='123')
        self.assertIsNotNone(lista_disponibilidad)
        self.assertIn(reserva, lista_disponibilidad)

class testReservaEspecifica(TestCase):
    def setUp(self):
        self.client = Client()
        Usuario.objects.create(username='Juan')
        TipoRecurso.objects.create(nombre="Proyector", descripcion_defecto="Esto es un Proyector")
        Recurso.objects.create(codigo='123', tipo=TipoRecurso.objects.get(nombre="Proyector"), disponible=True,
                               caracteristica="Esto es una Equipo", dias_vida_util=1000,
                               ultimo_mantenimiento=date.today())
        Reserva.objects.create(id = '1',fecha='2017-06-05', hora_inicio= 1, hora_fin = 2, recurso = Recurso.objects.get(codigo = '123'), tipo = 1, estado = 1, responsable = Usuario.objects.get(username='Juan'), posicion = 1)

    def test_creacion(self):
        lista_disponibilidad = Reserva.objects.all().filter(tipo=1)
        reserva = Reserva.objects.get(recurso__codigo='123')
        self.assertIsNotNone(lista_disponibilidad)
        self.assertIn(reserva, lista_disponibilidad)

