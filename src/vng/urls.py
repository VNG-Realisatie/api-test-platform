from django.conf import settings
from django.conf.urls import include, url
from django.conf.urls.static import static
from django.contrib import admin
from django.contrib.auth import views as auth_views
from django.contrib.staticfiles.urls import staticfiles_urlpatterns
from django.views.generic.base import TemplateView
from .decorators import anonymous_required
from .base_url import *

urlpatterns = base_urlpatterns + [
    # redirect the request to the testession
    url(r'^api/auth/', include('vng.apiAuthentication.urls', namespace='apiv1_auth')),
    url(r'^api/v1/', include('vng.testsession.urls_api', namespace='apiv1session')),
    url(r'^api/v1/', include('vng.servervalidation.urls_api', namespace='apiv1server')),
    url(r'^api/v1/', include('vng.openApiInspector.urls_api', namespace='apiv1inspector')),
    url(r'^server/', include('vng.servervalidation.urls', namespace='server_run')),
    url(r'^inspector/', include('vng.openApiInspector.urls', namespace='open_api_inspector')),
    url(r'^', include('vng.testsession.urls', namespace='testsession')),
    url(r'^', include('vng.testsession.urls_api_sub', namespace='serverproxy')),
]
