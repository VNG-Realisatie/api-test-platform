import factory
from django_webtest import WebTest
from django.urls import reverse
from factory.django import DjangoModelFactory as Dmf
from vng.testsession.tests.factories import UserFactory
from .factories import TestScenarioFactory, ServerRunFactory, TestScenarioUrlFactory
from vng.servervalidation.models import ServerRun


class TestCreation(WebTest):

    def setUp(self):
        self.tsf = TestScenarioUrlFactory().test_scenario
        self.user = UserFactory()

    def test_creation_error_list(self):
        call = self.app.get(reverse('server_run:server-run_list'), user='test')
        assert 'Started' not in str(call.body)

        call = self.app.get(reverse('server_run:server-run_list'), user='test')
        form = call.forms[0]
        form['test_scenario'].force_value('9')
        form.submit()
        call = self.app.get(reverse('server_run:server-run_list'), user='test')
        assert 'Started' not in str(call.body)

    def test_scenarios(self):
        call = self.app.get(reverse('server_run:server-run_list'), user=self.user)
        form = call.forms[0]
        form['test_scenario'].select(text=self.tsf.name)
        res = form.submit().follow()
        form = res.forms[0]
        form['url'] = 'https://ref.tst.vng.cloud/drc/api/v1/'
        form['Client ID'] = 'client id'
        form['Secret'] = 'secret'
        form.submit()
        call = self.app.get(reverse('server_run:server-run_list'), user=self.user)
        self.assertIn(self.user.username, call.text)


class TestList(WebTest):

    def setUp(self):
        TestScenarioFactory()
        ServerRunFactory()

    def test_list(self):
        call = self.app.get(reverse('server_run:server-run_list'), user='test')
        assert 'no session' not in str(call.body)
