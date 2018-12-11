from django.utils import timezone
import factory
from factory.django import DjangoModelFactory as Dmf
from vng.accounts.models import User
from ..models import SessionType, Session, Scenario, ScenarioCase
from ...utils import choices


class SessionTypeFactory(Dmf):

    class Meta:
        model = SessionType

    name = factory.sequence(lambda n: 'testype %d' % n)
    docker_image = 'di'


class UserFactory(Dmf):

    class Meta:
        model = User

    username = 'test'
    password = factory.PostGenerationMethodCall('set_password', 'pippopippo')


class ScenarioFactory(Dmf):

    class Meta:
        model = Scenario

    standard = 'Stardard'
    role = 'Role'
    application = 'Application'
    version = '1.2.4'


class ScenarioCaseFactory(Dmf):

    class Meta:
        model = ScenarioCase

    url = 'unknown/23'
    HTTP_method = choices.HTTPMethodChoiches.GET
    scenario = factory.SubFactory(ScenarioFactory)


class SessionFactory(Dmf):

    class Meta:
        model = Session

    session_type = factory.SubFactory(SessionTypeFactory)
    started = timezone.now()
    status = choices.StatusChoices.starting
    user = factory.SubFactory(UserFactory)
    api_endpoint = 'https://reqres.in/api/'
    exposed_api = 'tst'
    scenario = factory.SubFactory(ScenarioFactory)
