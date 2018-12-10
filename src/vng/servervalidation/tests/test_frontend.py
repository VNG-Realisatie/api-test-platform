import factory
from django_webtest import WebTest
from django.urls import reverse
from factory.django import DjangoModelFactory as Dmf
from .factories import TestScenarioFactory, ServerRunFactory
from vng.servervalidation.models import ServerRun


class TestCreation(WebTest):

    def setUp(self):
        TestScenarioFactory()

    def test_creation_list(self):
        call = self.app.get(reverse('server_run:server-run_list'), user='test')
        assert 'Started' not in str(call.body)

        call = self.app.get(reverse('server_run:server-run_list'), user='test')
        form = call.forms[0]
        form['test_scenario'].select('1')
        form['api_endpoint'] = 'http:google.com'
        # form.submit()
        #call = self.app.get(reverse('server_run:server-run_list'), user='test')
        #assert 'Started' in str(call.body)

    def test_creation_error_list(self):
        call = self.app.get(reverse('server_run:server-run_list'), user='test')
        assert 'Started' not in str(call.body)

        call = self.app.get(reverse('server_run:server-run_list'), user='test')
        form = call.forms[0]
        form['test_scenario'].force_value('9')
        form.submit()
        call = self.app.get(reverse('server_run:server-run_list'), user='test')
        assert 'Started' not in str(call.body)


class TestList(WebTest):

    def setUp(self):
        TestScenarioFactory()
        ServerRunFactory()

    def test_list(self):
        call = self.app.get(reverse('server_run:server-run_list'), user='test')
        assert 'no session' not in str(call.body)

    def test_run_test(self):
        call = self.app.get(reverse('server_run:server-run_list'), user='test')
        form = call.forms[0]
        form['test_scenario'].force_value('1')
        form['api_endpoint'].force_value('https://google.com')
        # form.submit()
        sr = ServerRun.objects.latest('id')
        #call = self.app.get(reverse('server_run:server-run_detail', pk=sr.pk), user='test')
