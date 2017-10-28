from django.test import TestCase,Client
from recursos.models import Recurso
from recursos.models import TipoRecurso
from django.shortcuts import reverse
from datetime import date

class testConsultaRecurso(TestCase):
    def setUp(self):
        self.client = Client()
        TipoRecurso.objects.create(nombre="Proyector", descripcion_defecto="Esto es un Proyector")
        Recurso.objects.create(codigo='123', tipo=TipoRecurso.objects.get(nombre="Proyector"), disponible=True,
                               caracteristica="Esto es una Equipo", dias_vida_util=1000,
                               ultimo_mantenimiento=date.today())

    def test_creacion(self):
        proyectorX = Recurso.objects.get(codigo='123')
        self.assertIsNotNone(proyectorX)

        response = self.client.get('/recursos/consultar')
        self.assertEqual(response.status_code, 200)
        response = self.client.get(reverse('detalle_recurso', kwargs={'pk': proyectorX.id}))
        self.assertEqual(response.status_code, 200)






