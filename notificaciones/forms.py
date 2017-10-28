from django import forms

class notificarAveriadoForm(forms.Form):
    '''Clase para representar un formulario que sirve en la busqueda de recursos por medio del codigo de recurso'''
    codigo = forms.CharField(max_length=30, label="Ingrese el codigo del recurso", widget=forms.TextInput(attrs={'placeholder': 'Codigo'}))