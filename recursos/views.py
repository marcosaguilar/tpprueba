from django.shortcuts import render_to_response, get_object_or_404
from django.views.generic import ListView, DetailView, FormView
from .forms import reporte_recurso_form
from recursos.models import Recurso
from django.urls import reverse, reverse_lazy
from django.shortcuts import get_object_or_404
from django.views.generic.edit import FormMixin

class listar_recurso(ListView):
    '''Vista que se utiliza para listar los recursos'''
    model = Recurso
    template_name = 'recursos/consultarRecursos.html'

class detalle_recurso(DetailView):
    '''Vista que se utiliza para mostrar los detalles de los recursos'''
    model = Recurso
    template_name = 'recursos/detalleRecursos.html'

#class reporte_recursos(ListView, FormView):
#    form_class = reporte_recurso_form
#    model = Recurso
#    template_name = 'recursos/reporte.html'
#    success_url = reverse_lazy('reporte_recursos')


#    def get_queryset(self):
#        form = self.get_form()

#        return Recurso.objects.filter(id=1)
class FormListView(FormMixin, ListView):
    def get(self, request, *args, **kwargs):
        # From ProcessFormMixin
        form_class = self.get_form_class()
        self.form = self.get_form(form_class)
        try:
            tipo = self.form.data['tipo']
            responsable = self.form.data['responsable']
            estado = self.form.data['estado']
            if (estado[0] =='0'):
                self.object_list = self.get_queryset()
            else:
                self.object_list = self.get_queryset().filter(disponible=estado)

            if (tipo != ''):
                self.object_list = self.object_list.filter(tipo=tipo)

            if (responsable != ''):
                self.object_list = self.object_list.filter(administrador=responsable)
        except:
            self.object_list = self.get_queryset()
        allow_empty = self.get_allow_empty()
        if not allow_empty and len(self.object_list) == 0:
            raise (u"Empty list and '%(class_name)s.allow_empty' is False.")

        context = self.get_context_data(object_list=self.object_list, form=self.form)
        return self.render_to_response(context)

    def post(self, request, *args, **kwargs):
        return self.get(request, *args, **kwargs)


class reporte_recursos(FormListView):
    form_class = reporte_recurso_form
    model = Recurso
    template_name = 'recursos/reporte.html'
    success_url = reverse_lazy('reporte_recursos')