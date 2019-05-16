from django.conf import settings as django_settings

from ..testsession.models import Session
from ..servervalidation.models import ServerRun
from .choices import StatusChoices, StatusWithScheduledChoices


def settings(request):
    public_settings = ('GOOGLE_ANALYTICS_ID', 'ENVIRONMENT',
                       'SHOW_ALERT', 'PROJECT_NAME')

    context = {
        'settings': dict([
            (k, getattr(django_settings, k, None)) for k in public_settings
        ]),
    }

    if hasattr(django_settings, 'RAVEN_CONFIG'):
        context.update(dsn=django_settings.RAVEN_CONFIG.get('public_dsn', ''))
    if request.user.is_authenticated:
        context['session_active'] = Session.objects.filter(user=request.user, status=StatusChoices.running).count()
        context['server_scheduled'] = ServerRun.objects.filter(user=request.user, scheduled=True, status=StatusWithScheduledChoices.scheduled).count()
    return context
