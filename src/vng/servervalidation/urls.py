from django.conf.urls import url
from django.contrib.auth.decorators import login_required
from django.views.generic import TemplateView

from . import views, apps

app_name = apps.AppConfig.__name__

urlpatterns = [
    url(r'^testscenario/(?P<pk>[0-9]+)', views.SessionTypeDetail.as_view(), name='testscenario-detail'),
    url(r'(?P<test_id>[0-9]+)/create', views.CreateEndpoint.as_view(), name='server-run_create'),
    url(r'create$', views.ServerRunForm.as_view(), name='server-run_create_item'),
    url(r'postman/(?P<pk>[0-9]+)', views.PostmanDownloadView.as_view(), name='postman_download'),
    url(r'scheduled$', views.TestScenarioSelectScheduled.as_view(), name='server-run_list_scheduled'),
    url(r'(?P<server_id>[0-9]+)/stop', views.StopServer.as_view(), name='server-run_stop'),
    url(r'(?P<server_id>[0-9]+)/trigger', views.TriggerServerRun.as_view(), name='server-run_trigger'),
    url(r'(?P<uuid>[0-9a-f-]+)/log_json', views.ServerRunLogJsonView.as_view(), name='server-run_detail_log_json'),
    url(r'(?P<uuid>[0-9a-f-]+)/log', views.ServerRunLogView.as_view(), name='server-run_detail_log'),
    url(r'(?P<uuid>[0-9a-f-]+)/pdf', views.ServerRunPdfView.as_view(), name='server-run_detail_pdf'),
    url(r'^(?P<pk>[0-9]+)$', views.ServerRunOutput.as_view(), name='server-run_detail'),
    url(r'(?P<uuid>[0-9a-f-]+)', views.ServerRunOutputUuid.as_view(), name='server-run_detail_uuid'),
    url(r'$', views.TestScenarioSelect.as_view(), name='server-run_list'),
]
