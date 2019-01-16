from django.contrib import admin
import vng.servervalidation.models as model


def get_all_fields(mo):
    l = [field.name for field in mo._meta.fields]
    l.remove('id')
    return l


class EndpointInline(admin.TabularInline):
    model = model.Endpoint


class TestScenarioUrlInline(admin.TabularInline):
    model = model.TestScenarioUrl


@admin.register(model.Endpoint)
class EndpointAdmin(admin.ModelAdmin):
    list_display = ['test_scenario_url', 'jwt', 'server_run', 'url']
    list_filter = ['test_scenario_url', 'server_run', 'url']
    search_fields = ['test_scenario_url', 'server_run', 'url']


@admin.register(model.ServerRun)
class ServerRunAdmin(admin.ModelAdmin):
    list_display = ['test_scenario', 'started', 'stopped', 'user', 'status', 'log']
    list_filter = ['user']
    search_fields = ['user']

    inlines = [EndpointInline]


@admin.register(model.TestScenario)
class TestScenarioAdmin(admin.ModelAdmin):
    list_display = ['name', 'validation_file']
    list_filter = ['name']
    search_fields = ['name']

    inlines = [TestScenarioUrlInline]


@admin.register(model.TestScenarioUrl)
class TestScenarioUrlAdmin(admin.ModelAdmin):
    list_display = ['name', 'test_scenario']
    list_filter = ['name', 'test_scenario']
    search_fields = ['name', 'test_scenario']
