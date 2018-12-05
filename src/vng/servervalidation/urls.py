from django.conf.urls import url
from django.contrib.auth.decorators import login_required

from . import views

urlpatterns = [
    url('$', login_required(views.ServerRunView.as_view()), name='server-run_list'),
    url('(?P<session_id>[0-9]+)/stop', login_required(views.stop_session), name='server-run_stop'),
    url('(?P<pk>[0-9]+)/log', login_required(views.ServerRunLogView.as_view()), name='server-run_detail_log'),
    url('(?P<pk>[0-9]+)', login_required(views.ServerRunOutput.as_view()), name='server-run_detail'),
]
