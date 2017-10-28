from django.shortcuts import render, get_object_or_404
from django.views.generic import ListView, DetailView, FormView, TemplateView
from .models import Reserva,Horas_catedras
from .forms import ReservaDisponibilidadForm,reporte_reserva_form
from datetime import timedelta,date
from recursos.models import Recurso
from django.urls import reverse,reverse_lazy
from django.views.generic.edit import FormMixin
from django.core.mail import send_mail
from notificaciones.models import notificacion
from .models import ControlReserva


class listar_reservas(ListView):
    '''Vista que se utiliza para listar las reservas'''
    model = Reserva
    template_name = 'reservas/ConsultaDeReservas.html'
    def get_queryset(self):
        return Reserva.objects.filter(responsable=self.request.user)

def reserva_disponibilidad(request):
    '''Vista utilizada para la creacion de las reservas segun disponibilidad de Recursos'''
    if request.method == "POST":
        form = ReservaDisponibilidadForm(request.POST)
        if form.is_valid():
            tipo = form.cleaned_data['tipo']
            fecha = form.cleaned_data['fecha']
            inicio = int(form.cleaned_data['inicio'])
            fin = int(form.cleaned_data['fin'])
            solicitante = request.user
            dias = 7  #rango maximo de dias en el que se puede realizar una reserva
            if(fecha - timedelta(days=dias) <= date.today() ):
                recursosReservas = Reserva.objects.all().exclude(estado__exact='3').values_list('recurso',flat=True).distinct()
                recursos = Recurso.objects.filter(tipo=tipo,disponible=True)
                recurso = None
                for rec in recursos:
                    disponible = True
                    if (rec.id in recursosReservas):
                        reservas = Reserva.objects.filter(recurso=rec,fecha__exact=fecha)
                        for reserva in reservas:
                            if inicio < reserva.hora_inicio and fin > reserva.hora_inicio:
                                disponible = False
                                break
                            elif inicio >= reserva.hora_inicio and inicio < reserva.hora_fin:
                                disponible = False
                                break
                        if(disponible == True):
                            recurso = rec
                            break
                    else:
                        recurso = rec
                        break
                if (recurso == None):
                    return render(request, 'reservas/reserva_disponibilidad.html',{'mensaje': 'No se encontro ningun recurso Disponible'})
                reserva = Reserva.objects.create(fecha=fecha,hora_inicio=inicio,hora_fin=fin,recurso=recurso,tipo=0,estado=1,responsable=solicitante)
                reserva.save()
                controlRes = ControlReserva.objects.create(estado = 0, reserva_id = reserva.id)
                controlRes.save()
                enviar_correo(solicitante,inicio ,fin ,fecha,recurso)

                return render(request, 'reservas/reserva_disponibilidad.html',{'mensaje': 'Su reserva fue creada correctamente'})
            else:
                return render(request, 'reservas/reserva_disponibilidad.html',{'mensaje': 'Solo se puede realizar reservas en un plazo de '+ str(dias) + ' dias'})
    else:
        form = ReservaDisponibilidadForm()
    return render(request, 'reservas/reserva_disponibilidad.html', {'form': form})

def enviar_correo(solicitante, inicio , fin ,fecha,recurso):
    '''Metodo utilizado para enviar el correo electronico al solicitante'''
    email = solicitante.email
    subject = notificacion.objects.get(titulo="Reserva Acreditada").titulo
    message = notificacion.objects.get(titulo="Reserva Acreditada").texto + \
              "\nSolicitante: " + solicitante.first_name + " " + solicitante.last_name + \
              "\nRecurso: " + recurso.__str__() + \
              "\nFecha: " + str(fecha) + \
              "\nHora Inicio :" + Horas_catedras[inicio][1] + \
                        "\nHora Fin: " + Horas_catedras[fin][1] + "\n"
    send_mail(subject,message,"teamsgr17@gmail.com",[email])

class dashboardFranjaview(TemplateView):

    template_name = "portalPublico/dashboardFranjaHoraria.html"

    def get_lista_horas(self):
        lista_horas = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        reservas=Reserva.objects.all().exclude(estado="4")
        for reserva in reservas:
            for i in range(reserva.hora_inicio, reserva.hora_fin + 1, 1):
                lista_horas[i]+=1
        return lista_horas
    def get_labels(self):
        labels= []
        for label in Horas_catedras:
            labels.append(label[1])
        return labels

    def get_context_data(self, **kwargs):
        context = super(dashboardFranjaview, self).get_context_data(**kwargs)
        context['data'] = self.get_lista_horas()
        context['labels'] = self.get_labels()
        return context



class FormListView(FormMixin,ListView):
    def get(self, request, *args, **kwargs):
        # From ProcessFormMixin
        form_class = self.get_form_class()
        self.form = self.get_form(form_class)
        try:
            tipo = self.form.data['tipo']
            responsable = self.form.data['responsable']
            estado = self.form.data['estado']
            fecha = self.form.data['fecha']
            fecha = fecha[6:10] + '-' + fecha[3:5] + '-' + fecha[0:2]
            if (estado == 'vacio'):
                self.object_list = self.get_queryset()
            else:
                self.object_list = self.get_queryset().filter(estado=estado)

            if (tipo != ''):
                self.object_list = self.object_list.filter(tipo=tipo)

            if (responsable != ''):
                self.object_list = self.object_list.filter(responsable=responsable)

            if (fecha != '' and fecha != '--'):
                self.object_list = self.object_list.filter(fecha=fecha)

        except:
            self.object_list = self.get_queryset()
        allow_empty = self.get_allow_empty()
        if not allow_empty and len(self.object_list) == 0:
            raise (u"Empty list and '%(class_name)s.allow_empty' is False.")

        context = self.get_context_data(object_list=self.object_list, form=self.form)
        return self.render_to_response(context)

    def post(self, request, *args, **kwargs):
        return self.get(request, *args, **kwargs)

class reporte_reservas(FormListView):
    form_class = reporte_reserva_form
    model = Reserva
    template_name = 'reservas/reporte.html'
    success_url = reverse_lazy('reporte_reservas')