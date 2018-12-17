from django.contrib import admin
import vng.testsession.models as model

from ordered_model.admin import OrderedModelAdmin


def get_all_fields(mo):
    l = [field.name for field in mo._meta.fields]
    l.remove('id')
    l.append('id')
    return l


class VNGEndpointInline(admin.TabularInline):
    model = model.VNGEndpoint


class ScenarioCaseInline(admin.TabularInline):
    model = model.ScenarioCase


@admin.register(model.SessionType)
class SessionTypeAdmin(admin.ModelAdmin):
    list_display = get_all_fields(model.SessionType)
    list_filter = ['name']
    search_fields = ['name']

    inlines = [VNGEndpointInline]


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


@admin.register(model.ScenarioCase)
class ScenarioCaseAdmin(OrderedModelAdmin):
    list_display = ('url', 'move_up_down_links', 'http_method', 'result', 'vng_endpoint')
    list_filter = ['vng_endpoint']
    search_fields = ['vng_endpoint']


@admin.register(model.TestSession)
class TestSessionAdmin(admin.ModelAdmin):
    list_display = get_all_fields(model.TestSession)
    list_filter = ['test_file', 'name']
    search_fields = ['test_file', 'name']


@admin.register(model.VNGEndpoint)
class VNGEndpointAdmin(admin.ModelAdmin):
    list_display = get_all_fields(model.VNGEndpoint)

    inlines = [ScenarioCaseInline]
