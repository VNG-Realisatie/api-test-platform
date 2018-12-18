from django.utils import timezone
import factory
from factory.django import DjangoModelFactory as Dmf
from vng.accounts.models import User
from django.conf import settings
from ..models import SessionType, Session, ScenarioCase, VNGEndpoint, ExposedUrl, SessionLog, TestSession
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

    name = factory.Sequence(lambda n: 'name%s' % n)
    url = 'http://ref.tst.vng.cloud/drc/api/v1'
    session_type = factory.SubFactory(SessionTypeFactory)


class UserFactory(Dmf):

    class Meta:
        model = User

    username = factory.Sequence(lambda n: 'test%s' % n)
    password = factory.PostGenerationMethodCall('set_password', 'password')


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
    name = factory.Sequence(lambda n: 'name%s' % n)


class TestSessionFactory(Dmf):

    class Meta:
        model = TestSession

    test_file = factory.django.FileField(from_path=settings.MEDIA_ROOT + '/VNG.postman_collection.json')


class ExposedUrlFactory(Dmf):

    class Meta:
        model = ExposedUrl

    exposed_url = factory.Sequence(lambda n: 'tst%s' % n)
    session = factory.SubFactory(SessionFactory)
    vng_endpoint = factory.SubFactory(VNGEndpointFactory)
    test_session = factory.SubFactory(TestSessionFactory)

    def __init___(self, **args):
        super().__init__(**args)
        self.vng_endpoint.session_type = self.session.session_type


class SessionLogFactory(Dmf):

    class Meta:
        model = SessionLog

    date = timezone.now()
    session = factory.SubFactory(SessionFactory)
    request = '{"request": {"path": "GET http://localhost:8000/runtest/154513515134/", "body": ""}}'
    response = '{"response": {"status_code": 404, "body": "{}", "path": "{} http://localhost:8000/runtest/tst/unknown/23"}}'
    response_status = 404
