from rest_framework import routers, serializers, viewsets
from rest_framework.documentation import include_docs_urls

from django.conf.urls import url, include
from django.conf.urls import url
from django.contrib.auth.decorators import login_required

from . import api_views, apps
from ..utils.schema_view import schema_view

app_name = apps.AppConfig.__name__

session_detail = api_views.SessionViewSet.as_view({
    'get': 'retrieve',
    'put': 'update',
    'delete': 'destroy'
})

session_list = api_views.SessionViewSet.as_view({
    'get': 'list',
    'post': 'create'
})

router = routers.SimpleRouter()
router.register(r'testsessions/', api_views.SessionViewSet, 'test_session')
router.register(r'stop-session/', api_views.StopSessionView, 'stop_session')
router.register(r'sessiontypes/', api_views.SessionTypesViewSet, 'session_types')
router.register(r'exposed_url/', api_views.ExposedUrlView, 'sessionTypes')


urlpatterns = router.urls


urlpatterns += [
    url(r'result-session/(?P<pk>[0-9]+)', api_views.ResultSessionView.as_view(), name='result_session'),
    url(r'runtest/(?P<url>([^/])+)/$', login_required(api_views.RunTest.as_view()), name='sessionTypes'),
    url(r'^schema/', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
]
