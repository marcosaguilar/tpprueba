from administracion.models import Usuario
from django.views.generic.edit import  FormView
from administracion.forms import UsuarioForm
from django.shortcuts import render

class CrearUsuario(FormView):
    '''Vista que se utiliza para la creacion de usuarios.
    @template_name es el temaplate a utilizar
    @success_url es la url donde se redirige al tener exito la operacion
    @form_class es el formulario a utilizar en la vista'''
    template_name = 'registro.html'
    success_url = 'solicitudAceptada'
    form_class = UsuarioForm

    def form_valid(self, form):
        '''Metodo que se ejecuta si el formulario es valido y se guardan el objeto en la base de datos'''
        self.object = form.save(commit=False)
        username = form.cleaned_data['username']
        nombre = form.cleaned_data['first_name']
        apellido = form.cleaned_data['last_name']
        correo = form.cleaned_data['email']
        ci = form.cleaned_data['ci']
        usuario = Usuario.objects.create(username = username, first_name = nombre, last_name = apellido, email = correo, ci = ci, is_active = False)
        usuario.set_password(form.cleaned_data['password'])
        usuario.save()
        return super(CrearUsuario, self).form_valid(form)

def solicitudAceptada(request):
    '''Vista que renderiza el template solicitudAcep.html'''
    return render(request, 'solicitudAcep.html',{})