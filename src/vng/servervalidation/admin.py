from django.contrib import admin
import vng.servervalidation.models as model

def get_all_fields(mo):
    l = [field.name for field in mo._meta.fields]
    l.remove('id')
    return l

@admin.register(model.ServerRun)
class ServerRunAdmin(admin.ModelAdmin):
    list_display = get_all_fields(model.ServerRun)
    list_filter = ['user']
    search_fields = ['user','api_endpoint']


@admin.register(model.TestScenario)
class TestScenarioAdmin(admin.ModelAdmin):
    list_display = get_all_fields(model.TestScenario)
    list_filter = ['name']
    search_fields = ['name']
