from django.contrib import admin
import vng.testsession.models as model


def get_all_fields(mo):
    l = [field.name for field in mo._meta.fields]
    l.remove('id')
    return l


@admin.register(model.SessionType)
class SessionTypeAdmin(admin.ModelAdmin):
    list_display = get_all_fields(model.SessionType)
    list_filter = ['name']
    search_fields = ['name']


@admin.register(model.Session)
class SessionAdmin(admin.ModelAdmin):
    list_display = get_all_fields(model.Session)
    list_filter = ['user']
    search_fields = ['user', 'api_endpoint']


@admin.register(model.SessionLog)
class SessionLogAdmin(admin.ModelAdmin):
    list_display = get_all_fields(model.SessionLog)
    list_filter = ['session', 'date']
    search_fields = ['session', 'date']


@admin.register(model.Scenario)
class ScenarioAdmin(admin.ModelAdmin):
    list_display = get_all_fields(model.Scenario)
    list_filter = ['version', 'application']
    search_fields = ['version', 'application']


@admin.register(model.ScenarioCase)
class ScenarioCaseAdmin(admin.ModelAdmin):
    list_display = get_all_fields(model.ScenarioCase)
