from django.conf.urls import include, url
from . import views

urlpatterns = [
        url(r'^consultar$', views.listar_recurso.as_view(), name='consultarRecursos'),
        url(r'^(?P<pk>[-\w]+)/$', views.detalle_recurso.as_view(), name='detalle_recurso'),
        url(r'^reporte$', views.reporte_recursos.as_view(), name='reporte_recursos'),

]