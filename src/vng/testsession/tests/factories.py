from django.utils import timezone
import factory
from factory.django import DjangoModelFactory as Dmf
from vng.accounts.models import User
from ..models import SessionType, Session, ScenarioCase, VNGEndpoint
from ...utils import choices


class SessionTypeFactory(Dmf):

    class Meta:
        model = SessionType

    name = factory.sequence(lambda n: 'testype %d' % n)
    standard = 'Stardard'
    role = 'Role'
    application = 'Application'
    version = '1.2.4'


class VNGEndpointFactory(Dmf):

    class Meta:
        model = VNGEndpoint

    name = 'DRC'
    url = 'http://ref.tst.vng.cloud/drc/api/v1'
    session_type = factory.SubFactory(SessionTypeFactory)


class UserFactory(Dmf):

    class Meta:
        model = User

    username = 'test'
    password = factory.PostGenerationMethodCall('set_password', 'pippopippo')


class ScenarioCaseFactory(Dmf):

    class Meta:
        model = ScenarioCase

    url = 'unknown/23'
    http_method = choices.HTTPMethodChoiches.GET
    vng_endpoint = factory.SubFactory(VNGEndpointFactory)


class SessionFactory(Dmf):

    class Meta:
        model = Session

    session_type = factory.SubFactory(SessionTypeFactory)
    started = timezone.now()
    status = choices.StatusChoices.starting
    user = factory.SubFactory(UserFactory)
    session_type = factory.SubFactory(SessionTypeFactory)
