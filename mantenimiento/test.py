from django.test import TestCase,Client
from recursos.models import Recurso
from recursos.models import TipoRecurso
from django.shortcuts import reverse
from .models import Mantenimiento
from datetime import date

class testMantenimientoCorrectivo(TestCase):
    def setUp(self):
        self.client = Client()
        TipoRecurso.objects.create(nombre="Proyector",descripcion_defecto="Esto es un Proyector")
        Recurso.objects.create(codigo='123',tipo=TipoRecurso.objects.get(nombre="Proyector"),disponible=True,caracteristica="Esto es una Equipo",dias_vida_util=1000,ultimo_mantenimiento=date.today())
        Mantenimiento.objects.create(detalle="rotura de Lente",tipo=1,recurso=Recurso.objects.get(codigo='123'),estado=0)

    def test_correctivo(self):
        lista_correctivo = Mantenimiento.objects.all().filter(tipo=1)
        mantenimiento = Mantenimiento.objects.get(recurso__codigo='123')
        self.assertIsNotNone(lista_correctivo)
        self.assertIn(mantenimiento,lista_correctivo,"El mantenimiento esta en la lista")


class testMantenimientoPreventivo(TestCase):
    def setUp(self):
        self.client = Client()
        TipoRecurso.objects.create(nombre="Proyector", descripcion_defecto="Esto es un Proyector")
        Recurso.objects.create(codigo='123', tipo=TipoRecurso.objects.get(nombre="Proyector"), disponible=True,caracteristica="Esto es una Equipo", dias_vida_util=1000,ultimo_mantenimiento=date.today())
        Mantenimiento.objects.create(detalle="rotura de Lente", tipo=0, recurso=Recurso.objects.get(codigo='123'),estado=0)

    def test_preventivo(self):
        lista_preventivo = Mantenimiento.objects.all().filter(tipo=0)
        mantenimiento = Mantenimiento.objects.get(recurso__codigo='123')
        self.assertIsNotNone(lista_preventivo)
        self.assertIn(mantenimiento, lista_preventivo, "El mantenimiento esta en la lista")
