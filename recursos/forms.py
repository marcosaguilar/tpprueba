from django import forms
from .models import TipoRecurso
from administracion.models import Usuario

class reporte_recurso_form(forms.Form):
    '''Clase que representa un formulario usado en la vista de Reportes de recursos'''
    tipo = forms.ModelChoiceField(queryset=TipoRecurso.objects.all(), required=False, initial=None)
    estado = forms.ChoiceField(widget=forms.Select(), choices=([('0','------------'),(True, 'Disponible'), (False, 'No Disponible')]),initial='0')
    responsable = forms.ModelChoiceField(queryset=Usuario.objects.filter(groups__name='Administrador de Recursos'), required=False, initial=None)
