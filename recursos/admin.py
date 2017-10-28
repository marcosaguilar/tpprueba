from django.contrib import admin
from .models import TipoRecurso, Recurso

# Register your models here.
admin.site.register(TipoRecurso)

@admin.register(Recurso)
class RecursoAdmin(admin.ModelAdmin):
    '''Clase que representa al model Admin en Recursos, utilizado para definir
    que campos seran visibles/editables dependiendo del tipo de usuario'''
    exclude = ['ultimo_mantenimiento', 'fecha_creacion', 'pendiente_de_mantenimiento', 'averiado']
    list_filter = ('disponible', 'tipo', 'averiado')
    admin.site.disable_action('delete_selected')

    def get_form(self, request, obj=None, **kwargs):
        '''Se sobrescribe el metodo get_form para excluir algunos campos'''
        self.list_display = ['tipo','codigo','disponible','ultimo_mantenimiento','siguiente_mantenimiento','administrador']
        roles = request.user.groups.values_list('name', flat=True)
        if not(request.user.is_superuser or "Administrador General" in roles):
            self.exclude = ['ultimo_mantenimiento', 'fecha_creacion', 'pendiente_de_mantenimiento', 'averiado', 'administrador', 'disponible']
        return super(RecursoAdmin, self).get_form(request, obj, **kwargs)

    def get_queryset(self, request):
        super(RecursoAdmin, self).get_queryset(request)
        roles = request.user.groups.values_list('name', flat=True)
        if request.user.is_superuser or "Administrador General" in roles:
            return Recurso.objects.all()
        return Recurso.objects.filter(administrador=request.user)

