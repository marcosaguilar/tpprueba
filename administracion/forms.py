from django import forms
from administracion.models import Usuario

class UsuarioForm(forms.ModelForm):
    '''Clase que representa al formulario de los usuarios donde se definen los campos que se desean incluir'''

    confirm_password = forms.CharField(widget=forms.PasswordInput(), label=('Vuelva a introducir su contraseña'))
    class Meta:
        model = Usuario
        fields = ['username','first_name','last_name','email','ci','password','confirm_password']

        widgets = {
            'password': forms.PasswordInput(),
            }

    def clean(self):
        '''Se sobreescribe el metodo clean para comprobar las contraseñas'''
        cleaned_data = super(UsuarioForm, self).clean()
        password = cleaned_data.get("password")
        confirm_password = cleaned_data.get("confirm_password")

        if password != confirm_password:
            raise forms.ValidationError(
                "Las contraseñas no coinciden"
            )