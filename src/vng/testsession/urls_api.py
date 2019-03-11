from rest_framework import routers, serializers, viewsets
from rest_framework.documentation import include_docs_urls

from django.conf.urls import url, include
from django.conf.urls import url
from django.contrib.auth.decorators import login_required

from . import api_views, apps
from ..utils.schema import schema_view

app_name = apps.AppConfig.__name__


router = routers.SimpleRouter()
router.register('testsessions', api_views.SessionViewSet, 'test_session')
router.register('sessiontypes', api_views.SessionTypesViewSet, 'session_types')
router.register('exposed_url', api_views.ExposedUrlView, 'sessionTypes')


urlpatterns = router.urls


urlpatterns += [
    url(r'testsessions/(?P<pk>[0-9]+)/stop$', api_views.StopSessionView.as_view(), name='stop_session'),
    url(r'testsessions/(?P<pk>[0-9]+)/result$', api_views.ResultSessionView.as_view(), name='result_session'),
    url(r'^schema/', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
]
