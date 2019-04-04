from django.utils import timezone
import factory
from factory.django import DjangoModelFactory as Dmf
from vng.accounts.models import User
from django.conf import settings
from filer.models import File
from ..models import SessionType, Session, ScenarioCase, VNGEndpoint, ExposedUrl, SessionLog, TestSession, QueryParamsScenario
from ...utils.factories import UserFactory
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


class FilerField(Dmf):
    class Meta:
        model = File

    file = factory.django.FileField(from_path=settings.POSTMAN_ROOT + '/google.postman_collection.json')


class VNGEndpointFactory(Dmf):

    class Meta:
        model = VNGEndpoint

    name = factory.Sequence(lambda n: 'name{}'.format(n))
    url = 'http://ref.tst.vng.cloud/drc/api/v1'
    session_type = factory.SubFactory(SessionTypeFactory)
    test_file = factory.SubFactory(FilerField)


class VNGEndpointEchoFactory(Dmf):

    class Meta:
        model = VNGEndpoint

    name = factory.Sequence(lambda n: 'nameecho{}'.format(n))
    url = 'https://postman-echo.com/'
    session_type = factory.SubFactory(SessionTypeFactory)
    test_file = factory.SubFactory(FilerField)


class VNGEndpointDockerFactory(Dmf):

    class Meta:
        model = VNGEndpoint

    name = factory.Sequence(lambda n: 'name_docker{}'.format(n))
    docker_image = 'maykinmedia/vng-demo-api:latest.db'
    session_type = factory.SubFactory(SessionTypeFactory)
    test_file = factory.SubFactory(FilerField)


class ScenarioCaseFactory(Dmf):

    class Meta:
        model = ScenarioCase

    url = 'unknown/23'
    http_method = choices.HTTPMethodChoiches.GET
    vng_endpoint = factory.SubFactory(VNGEndpointFactory)


class QueryParamsScenarioFactory(Dmf):

    class Meta:
        model = QueryParamsScenario

    scenario_case = factory.SubFactory(ScenarioCaseFactory)
    name = 'tparam'
    expected_value = '*'


class SessionFactory(Dmf):

    class Meta:
        model = Session

    session_type = factory.SubFactory(SessionTypeFactory)
    started = timezone.now()
    status = choices.StatusChoices.starting
    user = factory.SubFactory(UserFactory)
    session_type = factory.SubFactory(SessionTypeFactory)
    name = factory.Sequence(lambda n: 'name{}'.format(n))


class ExposedUrlEchoFactory(Dmf):

    class Meta:
        model = ExposedUrl

    test_session = factory.SubFactory(TestSessionFactory)
    session = factory.SubFactory(SessionFactory)
    vng_endpoint = factory.SubFactory(VNGEndpointEchoFactory)
    subdomain = factory.Sequence(lambda n: 'tstecho{}'.format(n))


class ExposedUrlFactory(Dmf):

    class Meta:
        model = ExposedUrl

    test_session = factory.SubFactory(TestSessionFactory)
    session = factory.SubFactory(SessionFactory)
    vng_endpoint = factory.SubFactory(VNGEndpointFactory)
    subdomain = factory.Sequence(lambda n: 'tst{}'.format(n))


class SessionLogFactory(Dmf):

    class Meta:
        model = SessionLog

    date = timezone.now()
    session = factory.SubFactory(SessionFactory)
    request = '{"request": {"path": "GET http://localhost:8000/runtest/154513515134/", "body": "", "header":"header"}}'
    response = '{"response": {"status_code": 404, "body": "{}", "path": "{} http://localhost:8000/runtest/tst/unknown/23"}}'
    response_status = 404
