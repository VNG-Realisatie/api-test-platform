import factory
from django.utils import timezone
from django.core.files.base import ContentFile
from factory.django import DjangoModelFactory as Dmf
from vng.accounts.models import User
from vng.testsession.tests.factories import UserFactory
from django.conf import settings
from ..models import ServerRun, TestScenario, TestScenarioUrl, PostmanTest, PostmanTestResult


class TestScenarioFactory(Dmf):

    class Meta:
        model = TestScenario

    name = factory.sequence(lambda n: 'testype %d' % n)


class PostmanTestFactory(Dmf):

    class Meta:
        model = PostmanTest
    test_scenario = factory.SubFactory(TestScenarioFactory)
    validation_file = factory.django.FileField(from_path=settings.MEDIA_ROOT + '/google.postman_collection.json')


class TestScenarioUrlFactory(Dmf):

    class Meta:
        model = TestScenarioUrl

    name = factory.sequence(lambda n: 'test_scenario_url %d' % n)
    test_scenario = factory.SubFactory(TestScenarioFactory)


class ServerRunFactory(Dmf):

    class Meta:
        model = ServerRun

    test_scenario = factory.SubFactory(TestScenarioFactory)
    user = factory.SubFactory(UserFactory)
    started = timezone.now()
    client_id = 'client_id_field'
    secret = 'secret_field'
