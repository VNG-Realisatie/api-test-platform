from django.conf import settings
from django.conf.urls import include, url
from django.conf.urls.static import static
from django.contrib import admin
from django.contrib.auth import views as auth_views
from django.contrib.staticfiles.urls import staticfiles_urlpatterns
from django.views.generic.base import TemplateView
from .decorators import anonymous_required

handler500 = 'vng.utils.views.server_error'
admin.site.site_header = 'vng admin'
admin.site.site_title = 'vng admin'
admin.site.index_title = 'Welcome to the vng admin'

urlpatterns = [
    # url(r'^admin_tools/', include('admin_tools.urls')),
    url(r'^admin/password_reset/$', auth_views.PasswordResetView.as_view(), name='admin_password_reset'),
    url(r'^admin/password_reset/done/$', auth_views.PasswordResetDoneView.as_view(), name='password_reset_done'),
    url(r'^admin/hijack/', include('hijack.urls')),
    url(r'^admin/', admin.site.urls),
    url(r'^reset/(?P<uidb64>[0-9A-Za-z_\-]+)/(?P<token>.+)/$',
        auth_views.PasswordResetConfirmView.as_view(), name='password_reset_confirm'),
    url(r'^reset/done/$', auth_views.PasswordResetCompleteView.as_view(), name='password_reset_complete'),

    # Simply show the master template.
    url(r'accounts/', include('registration.backends.default.urls')),
    url(r'accounts/', include('vng.accounts.urls', namespace='user_edit')),

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

# NOTE: The staticfiles_urlpatterns also discovers static files (ie. no need to run collectstatic). Both the static
# folder and the media folder are only served via Django if DEBUG = True.
urlpatterns += staticfiles_urlpatterns() + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

if settings.DEBUG and 'debug_toolbar' in settings.INSTALLED_APPS:
    import debug_toolbar
    urlpatterns += [
        url(r'^__debug__/', include(debug_toolbar.urls)),
    ]
