from django.test import Client, TestCase
from administracion.models import Usuario

class TestLogin(TestCase):
    def setUp(self):
        self.client = Client()
        usuario = Usuario.objects.create(username= 'Juan')
        usuario.set_password('Perez')
        usuario.save()

    def test(self):
        self.assertIsNotNone(Usuario.objects.get(username= 'Juan'))
        response = self.client.get('/auth/login')
        self.assertEqual(response.status_code, 200)
        response = self.client.post('/auth/login',{'username': 'Juan', 'password': 'Perez'})
        self.assertEqual(response.status_code, 302)
