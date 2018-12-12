from django.conf.urls import url
from django.contrib.auth.decorators import login_required

from . import views

urlpatterns = [
    url('(?P<server_id>[0-9]+)/stop', views.StopServer.as_view(), name='server-run_stop'),
    url('(?P<pk>[0-9]+)/log', views.ServerRunLogView.as_view(), name='server-run_detail_log'),
    url('(?P<pk>[0-9]+)', views.ServerRunOutput.as_view(), name='server-run_detail'),
    url('$', views.ServerRunView.as_view(), name='server-run_list'),
]
