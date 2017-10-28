from django.conf.urls import url
from . import views
urlpatterns = [
        url(r'^listarNotificaciones$', views.listar_notificaciones.as_view(), name='listarNotificaciones'),
        url(r'^(?P<pk>[-\w]+)/$', views.configurar_notificaciones.as_view(), name='configurarNotificaciones'),
        url(r'^notEquipAveriado', views.notificar_recurso_averiado, name='notEquipAveriado'),
        url(r'^NotificacionCorrecta', views.notificacion_correcta, name='NotificacionCorrecta'),
        url(r'^mantenimientoCorrectivo$', views.notificar_mantenimiento_correctivo, name='notificarMantenimentoCorrectivo'),
        url(r'^enviarNotificacion', views.enviar_mantenimiento_correctivo, name='enviarNotificacionMantenimientoCorrectivo'),
]