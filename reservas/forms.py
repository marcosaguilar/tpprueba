from django import forms
from recursos.models import TipoRecurso, Recurso
from .models import Horas_catedras,Reserva
import  datetime
from administracion.models import Usuario

class ReservaDisponibilidadForm(forms.Form):
    '''Formulario utilizado para la creacion de Reservas Segun Disponibilidad'''
    tipo = forms.ModelChoiceField(queryset=TipoRecurso.objects.all())
    fecha = forms.DateField()
    inicio = forms.ChoiceField(Horas_catedras)
    fin = forms.ChoiceField(Horas_catedras)

    def clean(self):
        cleaned_data = super(ReservaDisponibilidadForm,self).clean()
        fecha = cleaned_data.get("fecha")
        inicio = cleaned_data.get("inicio")
        fin = cleaned_data.get("fin")

        if fecha < datetime.date.today():
            raise forms.ValidationError("Inserte una Fecha Valida")

        if fin <= inicio:
            raise forms.ValidationError("La hora de fin debe ser mayor a la de inicio")

class reporte_reserva_form(forms.Form):
    '''Clase que representa un formulario usado en la vista de reportes de reservas'''
    tipo = forms.ModelChoiceField(queryset=Recurso.objects.all(), required=False, initial=None, label='Recurso')
    estado = forms.ChoiceField(widget=forms.Select(),
                               choices=([('vacio', '------------'), ('0', 'En Espera'),('1', 'Aprobado'),('2', 'Rechazado'),('3', 'Finalizado'),('4', 'Cancelado')]), initial='vacio')
    responsable = forms.ModelChoiceField(queryset=Usuario.objects.filter(groups__name='Solicitante'),
                                         required=False, initial=None)
    fecha = forms.DateField(input_formats=['%d-%M-%Y'],required= False)