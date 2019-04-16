from ordered_model.admin import OrderedModelAdmin
from django.contrib import admin

import vng.testsession.models as model

from .forms import SessionTypeForm


class VNGEndpointInline(admin.TabularInline):
    model = model.VNGEndpoint


class ScenarioCaseInline(admin.TabularInline):
    model = model.ScenarioCase


class ExposedUrlInline(admin.TabularInline):
    model = model.ExposedUrl


class QueryParamsScenarioInline(admin.TabularInline):
    model = model.QueryParamsScenario


class InjectHeaderInline(admin.TabularInline):
    model = model.InjectHeader


@admin.register(model.InjectHeader)
class InjectHeaderAdmin(admin.ModelAdmin):
    list_display = ['session_type', 'key', 'value']
    list_filter = ['session_type']
    search_fields = ['key', 'value']


@admin.register(model.ExposedUrl)
class ExposedUrlAdmin(admin.ModelAdmin):
    list_display = ['session', 'vng_endpoint', 'subdomain', 'id', 'test_session', 'docker_url']
    list_filter = ['session']
    search_fields = ['session__name']


@admin.register(model.SessionType)
class SessionTypeAdmin(admin.ModelAdmin):
    list_display = ['name', 'standard', 'role', 'application', 'version', 'header']
    list_filter = ['name']
    search_fields = ['name']

    inlines = [VNGEndpointInline, InjectHeaderInline]
    form = SessionTypeForm


@admin.register(model.Session)
class SessionAdmin(admin.ModelAdmin):
    list_display = [
        'started',
        'stopped',
        'session_type',
        'user',
        'status',
        'name',
        'id',
        'error_message',
        'deploy_status',
        'build_version',
    ]
    list_filter = ['user']
    search_fields = ['user', 'api_endpoint']
    inlines = [ExposedUrlInline]


@admin.register(model.SessionLog)
class SessionLogAdmin(admin.ModelAdmin):
    date_hierarchy = 'date'
    search_fields = ['session', 'date']
    list_display = ['date', 'session', 'response_status']


@admin.register(model.ScenarioCase)
class ScenarioCaseAdmin(OrderedModelAdmin):
    list_display = [
        'url',
        'move_up_down_links',
        'http_method',
        'vng_endpoint']
    list_filter = ['vng_endpoint__session_type']
    search_fields = ['vng_endpoint']
    inlines = [QueryParamsScenarioInline]


@admin.register(model.QueryParamsScenario)
class QueryParamsScenarioAdmin(admin.ModelAdmin):
    list_display = ['name', 'scenario_case', 'expected_value']
    list_filter = ['scenario_case']


@admin.register(model.TestSession)
class TestSessionAdmin(admin.ModelAdmin):
    list_display = [
        'test_result',
        'json_result',
    ]


@admin.register(model.VNGEndpoint)
class VNGEndpointAdmin(admin.ModelAdmin):
    list_display = [
        'url',
        'name',
        'docker_image',
        'session_type',
        'port',
        'test_file',
    ]
    inlines = [ScenarioCaseInline]


@admin.register(model.Report)
class ReportAdmin(admin.ModelAdmin):
    list_display = [
        'scenario_case',
        'session_log',
        'result'
    ]
