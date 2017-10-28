from django.conf.urls import include, url
from . import views

urlpatterns = [
        url(r'^consultar$', views.listar_reservas.as_view(), name='ConsultaDeReservas'),
        url(r'^reservaDisponibilidad', views.reserva_disponibilidad,name='ReservaDisponibilidad'),
        url(r'^reporte$', views.reporte_reservas.as_view(), name='reporte_reservas'),
        url(r'^dashboardFH$', views.dashboardFranjaview.as_view(),name='DashboardFH'),
    ]