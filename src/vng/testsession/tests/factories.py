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

    name = factory.sequence(lambda n: 'testype {}'.format(n))
    standard = 'Stardard'
    role = 'Role'
    application = 'Application'
    version = '1.2.4'


class TestSessionFactory(Dmf):

    class Meta:
        model = TestSession

    test_result = factory.django.FileField(filename='testsession')
    json_result = factory.django.FileField(filename='testsession')


class VNGEndpointFactory(Dmf):

    class Meta:
        model = VNGEndpoint

    name = factory.Sequence(lambda n: 'name{}'.format(n))
    url = 'http://ref.tst.vng.cloud/drc/api/v1'
    session_type = factory.SubFactory(SessionTypeFactory)
    test_file = factory.django.FileField(from_path=settings.POSTMAN_ROOT + '/google.postman_collection.json')


class UserFactory(Dmf):

    class Meta:
        model = User

    username = factory.Sequence(lambda n: 'test{}'.format(n))
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
    name = factory.Sequence(lambda n: 'name{}'.format(n))


class ExposedUrlFactory(Dmf):

    class Meta:
        model = ExposedUrl

    test_session = factory.SubFactory(TestSessionFactory)
    session = factory.SubFactory(SessionFactory)
    vng_endpoint = factory.SubFactory(VNGEndpointFactory)
    exposed_url = factory.Sequence(lambda n: 'tst{}'.format(n))


class SessionLogFactory(Dmf):

    class Meta:
        model = SessionLog

    date = timezone.now()
    session = factory.SubFactory(SessionFactory)
    request = '{"request": {"path": "GET http://localhost:8000/runtest/154513515134/", "body": "", "header":"header"}}'
    response = '{"response": {"status_code": 404, "body": "{}", "path": "{} http://localhost:8000/runtest/tst/unknown/23"}}'
    response_status = 404
