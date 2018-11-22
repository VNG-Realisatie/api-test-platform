from django.contrib import admin
import vng.testsession.models as model 


def get_all_fields(mo):
    l = [field.name for field in mo._meta.fields]
    l.remove('id')
    return l

# Register your models here.
@admin.register(model.SessionType)
class SessionTypeAdmin(admin.ModelAdmin):
    list_display = get_all_fields(model.SessionType)
    list_filter = ['name']
    search_fields = ['name']
 

@admin.register(model.Session)
class SessionAdmin(admin.ModelAdmin):
    list_display = get_all_fields(model.Session)
    list_filter = ['user']
    search_fields = ['user','api_endpoint']
    