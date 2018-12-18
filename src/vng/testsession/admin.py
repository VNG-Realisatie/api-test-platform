from django.contrib import admin
import vng.testsession.models as model

from ordered_model.admin import OrderedModelAdmin


class VNGEndpointInline(admin.TabularInline):
    model = model.VNGEndpoint


class ScenarioCaseInline(admin.TabularInline):
    model = model.ScenarioCase


class ExposedUrlInline(admin.TabularInline):
    model = model.ExposedUrl


@admin.register(model.ExposedUrl)
class ExposedUrl(admin.ModelAdmin):
    list_display = ['session', 'vng_endpoint', 'exposed_url']
    list_filter = ['session']
    search_fields = ['session']


@admin.register(model.SessionType)
class SessionTypeAdmin(admin.ModelAdmin):
    list_display = ['name', 'standard', 'role', 'application', 'version']
    list_filter = ['name']
    search_fields = ['name']

    inlines = [VNGEndpointInline]


@admin.register(model.Session)
class SessionAdmin(admin.ModelAdmin):
    list_display = [
        'name',
        'session_type',
        'started',
        'stopped',
        'status',
        'user',
        'api_endpoint',
        'port',
        'session_type',
        'test',
        'test_result',
        'json_result',
    ]
    list_filter = ['user']
    search_fields = ['user', 'api_endpoint']
    inlines = [ExposedUrlInline]


@admin.register(model.SessionLog)
class SessionLogAdmin(admin.ModelAdmin):
    list_display = [
        'date',
        'session',
        'request',
        'response',
        'response_status',
    ]
    list_filter = ['session', 'date']
    search_fields = ['session', 'date']


@admin.register(model.ScenarioCase)
class ScenarioCaseAdmin(OrderedModelAdmin):
    list_display = [
        'url',
        'move_up_down_links',
        'http_method',
        'result',
        'vng_endpoint']
    list_filter = ['vng_endpoint']
    search_fields = ['vng_endpoint']


@admin.register(model.TestSession)
class TestSessionAdmin(admin.ModelAdmin):
    list_display = ['name', 'test_file']
    list_filter = ['test_file', 'name']
    search_fields = ['test_file', 'name']


@admin.register(model.VNGEndpoint)
class VNGEndpointAdmin(admin.ModelAdmin):
    list_display = [
        'url',
        'name',
        'docker_image',
        'session_type',
    ]
    inlines = [ScenarioCaseInline]
