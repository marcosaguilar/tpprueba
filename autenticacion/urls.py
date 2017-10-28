from django.conf.urls import include, url
from django.contrib.auth.views import password_reset,password_reset_done,password_reset_complete,password_reset_confirm, password_change,password_change_done
from django.contrib.auth.views import login, logout
from . import views

urlpatterns = [
        url(r'^registro$', views.CrearUsuario.as_view(), name='registro'),
        url(r'^password_reset/$', password_reset ,name='password_reset'),
        url(r'^password_reset/done/$', password_reset_done, name='password_reset_done'),
        url(r'^reset/(?P<uidb64>[0-9A-Za-z_\-]+)/(?P<token>[0-9A-Za-z]{1,13}-[0-9A-Za-z]{1,20})/$', password_reset_confirm, name='password_reset_confirm'),
        url(r'^reset/done/$', password_reset_complete, name='password_reset_complete'),
        url(r'^accounts/password/change/$', password_change, name='password_change'),
        url(r'^accounts/password/change/done/$', password_change_done, name='password_change_done'),
        url(r'^login$', login, {'template_name': 'login.html', }, name="login"),
        url(r'^logout$', logout, {'template_name': 'home.html', }, name="logout"),
        url(r'^solicitudAceptada$', views.solicitudAceptada, name='solicitudAceptada'),
    ]