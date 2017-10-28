from django.test import Client, TestCase

class TestSolicitud(TestCase):
    def setUp(self):
        self.client = Client()

    def test(self):
        response = self.client.get('/auth/registro')
        self.assertEqual(response.status_code, 200)
        response = self.client.post('/auth/registro',{'confirm_password':'prueba','password':'prueba','username':'usuario','first_name':'Juan','last_name':'Perez','email':'JuanPerez@gmail.com','ci':'4444444'})
        self.assertEqual(response.status_code, 302)
        response = self.client.get('/auth/solicitudAceptada')
        self.assertEqual(response.status_code, 200)

