from django.test import TestCase
from django_webtest import WebTest
from .test_factory import ServerRunFactory, TestScenarioFactory

# Create your tests here.


class RetrieveTest(WebTest):

    def setUp(self):
        TestScenarioFactory()
        ServerRunFactory()

    def test_unauthenticated_user(self):
        call = self.app.get('/api/v1/sessiontypes', expect_errors=True)

    def test_creation_server_run(self):
