from django.conf.urls import include, url
from django.contrib.auth.decorators import login_required

from rest_framework import routers, serializers, viewsets

from . import views

urlpatterns = [
    url('^$', views.SessionListView.as_view(), name='sessions'),
    url(r'runtest/(?P<exposed_url>([^/])+)/(?P<relative_url>(.)*)$', views.RunTest.as_view(), name='run_test'),
    url('(?P<session_id>[0-9]+)/stop', views.StopSession.as_view(), name='stop_session'),
    url('(?P<session_id>[0-9]+)/report-pdf', views.SessionReportPdf.as_view(), name='session_report-pdf'),
    url('(?P<session_id>[0-9]+)/report', views.SessionReport.as_view(), name='session_report'),
    url('(?P<session_id>[0-9]+)/test-report-pdf', views.SessionTestReportPDF.as_view(), name='session-test_report-pdf'),
    url('(?P<session_id>[0-9]+)/test-report', views.SessionTestReport.as_view(), name='session-test_report'),
    url('(?P<session_id>\d+)/log/(?P<pk>\d+)', views.SessionLogDetailView.as_view(), name='session_log-detail'),
    url('(?P<session_id>\d+)/', views.SessionLogView.as_view(), name='session_log'),
]
