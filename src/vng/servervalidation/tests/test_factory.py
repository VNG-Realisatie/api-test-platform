import factory
from django.utils import timezone
from django.core.files.base import ContentFile
from factory.django import DjangoModelFactory as Dmf
from vng.accounts.models import User
from vng.testsession.tests.test_factory import UserFactory
from ..models import ServerRun, TestScenario


class TestScenarioFactory(Dmf):

    class Meta:
        model = TestScenario

    name = factory.sequence(lambda n:'testype %d' % n)
    validation_file = factory.LazyAttribute(
            lambda _: ContentFile(
                factory.django.ImageField()._make_data(
                    {'width': 1024, 'height': 768}
                ), 'example.jpg'
            )
        )


class ServerRunFactory(Dmf):

    class Meta:
        model = ServerRun

    test_scenario = factory.SubFactory(TestScenarioFactory)
    api_endpoint = 'http://google.com'
    user = factory.SubFactory(UserFactory)
    started = timezone.now()

