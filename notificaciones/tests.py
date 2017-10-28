from django.test import TestCase,Client
from .models import notificacion
from django.shortcuts import reverse

class testConfigurarNotificaciones(TestCase):
    def setUp(self):
        self.client = Client()
        notificacion.objects.create(titulo="Notificacion", texto="Esto es una notificacion")

    def test_creacion(self):
        noti = notificacion.objects.get(titulo='Notificacion')
        self.assertIsNotNone(noti)

        response = self.client.get('/notificaciones/listarNotificaciones')
        self.assertEqual(response.status_code, 200)
        response = self.client.get(reverse('configurarNotificaciones', kwargs={'pk': noti.id}))
        self.assertEqual(response.status_code, 200)

