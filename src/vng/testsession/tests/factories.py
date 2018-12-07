from django.utils import timezone
import factory
from factory.django import DjangoModelFactory as Dmf
from vng.accounts.models import User
from ..models import SessionType, Session
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


class SessionFactory(Dmf):

    class Meta:
        model = Session

    session_type = factory.SubFactory(SessionTypeFactory)
    started = timezone.now()
    status = choices.StatusChoices.starting
    user = factory.SubFactory(UserFactory)
    api_endpoint = 'http://google.com'
