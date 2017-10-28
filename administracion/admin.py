from django.contrib import admin
from .models import Rango, Usuario

@admin.register(Usuario)
class UsuarioAdmin(admin.ModelAdmin):
    '''Clase que represetan al modelo Admin. Utilizado para definir que campos seran visibles/editables para cada model'''
    exclude = ['penalizacion','password', 'permissions', 'is_superuser', 'date_joined', 'last_login', 'user_permissions','is_staff']
    list_filter = ('is_active',)
    list_display = ('username', 'first_name', 'last_name', 'ci', 'is_active')
    list_editable = ('is_active',)

    def save_model(self, request, obj, form, change):
        '''Se sobrescribe el metodo para enviar los campos que han sido modificados'''
        if('is_active' in form.changed_data):
            if('groups' in form.changed_data):
                form.changed_data.remove('groups')
            obj.save(update_fields = form.changed_data )
        else:
            super(UsuarioAdmin,self).save_model(request,obj,form,change)
admin.site.register(Rango)
