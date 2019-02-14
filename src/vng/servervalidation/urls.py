from django.conf.urls import url
from django.contrib.auth.decorators import login_required

from . import views, apps

app_name = apps.AppConfig.__name__

urlpatterns = [
    url('postman/(?P<pk>[0-9]+)', views.PostmanDownloadView.as_view(), name='postman_download'),
    url('(?P<server_id>[0-9]+)/stop', views.StopServer.as_view(), name='server-run_stop'),
    url('(?P<test_id>[0-9]+)/create', views.CreateEndpoint.as_view(), name='server-run_create'),
    url('(?P<pk>[0-9]+)/log_json', views.ServerRunLogJsonView.as_view(), name='server-run_detail_log_json'),
    url('(?P<pk>[0-9]+)/log', views.ServerRunLogView.as_view(), name='server-run_detail_log'),
    url('(?P<pk>[0-9]+)/pdf/(?P<postman_res_id>[0-9]+)', views.ServerRunPdfView.as_view(), name='server-run_detail_pdf'),
    url('(?P<pk>[0-9]+)', views.ServerRunOutput.as_view(), name='server-run_detail'),
    url('$', views.TestScenarioSelect.as_view(), name='server-run_list'),
]
