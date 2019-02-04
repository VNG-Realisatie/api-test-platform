from django.conf.urls import include, url
from django.contrib.auth.decorators import login_required

from rest_framework import routers, serializers, viewsets

from . import views
from . import api_views

urlpatterns = [
    url('^$', views.SessionListView.as_view(), name='sessions'),
    url(r'^postman/(?P<pk>[0-9]+)', views.PostmanDownloadView.as_view(), name='postman_download'),
    url(r'^runtest/(?P<exposed_url>[-\w]+)/(?P<name>[-\w]*)/(?P<relative_url>[-\w|/|.]*)$', api_views.RunTest.as_view(), name='run_test'),
    url(r'^(?P<session_id>[0-9]+)/stop', views.StopSession.as_view(), name='stop_session'),
    url(r'^(?P<session_id>[0-9]+)/report-pdf', views.SessionReportPdf.as_view(), name='session_report-pdf'),
    url(r'^(?P<session_id>[0-9]+)/report', views.SessionReport.as_view(), name='session_report'),
    url(r'^(?P<session_id>[0-9]+)/test-report-pdf/(?P<pk>[0-9]+)', views.SessionTestReportPDF.as_view(), name='session-test_report-pdf'),
    url(r'^(?P<session_id>[0-9]+)/test-report/(?P<pk>[0-9]+)', views.SessionTestReport.as_view(), name='session-test_report'),
    url(r'^(?P<session_id>[0-9]+)/log/(?P<pk>\d+)', views.SessionLogDetailView.as_view(), name='session_log-detail'),
    url(r'^(?P<session_id>[0-9]+)/', views.SessionLogView.as_view(), name='session_log'),
]
