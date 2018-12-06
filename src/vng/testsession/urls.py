from django.conf.urls import url
from django.contrib.auth.decorators import login_required

from . import views

urlpatterns = [
    url(r'^$', views.SessionListView.as_view(), name='sessions'),
    url(r'^(?P<session_id>[0-9]+)/log', views.SessionLogView.as_view(), name='session_log'),
    url(r'^(?P<session_id>[0-9]+)/stop', login_required(views.stop_session), name='stop_session'),

    url(r'runtest/(?P<url>([^/])+)/(?P<relative_url>(.)*)$', views.RunTest.as_view(), name='sessionTypes'),  # Obsolete?
]
