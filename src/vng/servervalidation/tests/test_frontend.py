import factory
from django_webtest import WebTest
from django.urls import reverse
from factory.django import DjangoModelFactory as Dmf
from .test_factory import TestScenarioFactory, ServerRunFactory
from vng.servervalidation.models import ServerRun


class TestCreation(WebTest):

    def setUp(self):
        TestScenarioFactory()

    def test_creation_list(self):
        call = self.app.get('/server/server-run_list', user='test')
        assert 'no session' in str(call.body)

        call = self.app.get('/server/start_server-run', user='test')
        form = call.forms[1]
        form['test_scenario'].force_value('1')
        form.submit()
        call = self.app.get('/server/server-run_list', user='test')
        assert 'no session' not in str(call.body)

    def test_creation_error_list(self):
        call = self.app.get('/server/server-run_list', user='test')
        assert 'no session' in str(call.body)

        call = self.app.get('/server/start_server-run', user='test')
        form = call.forms[1]
        form['test_scenario'].force_value('9')
        form.submit()
        call = self.app.get('/server/server-run_list', user='test')
        assert 'no session' in str(call.body)


class TestList(WebTest):

    def setUp(self):
        TestScenarioFactory()
        ServerRunFactory()

    def test_list(self):
        call = self.app.get('/server/server-run_list', user='test')
        assert 'no session' not in str(call.body)

    def test_run_test(self):
        call = self.app.get('/server/start_server-run', user='test')
        form = call.forms[1]
        form['test_scenario'].force_value('1')
        form['api_endpoint'].force_value('https://google.com')
        form.submit()
        sr = ServerRun.objects.latest('pk')
        call = self.app.get('/server/server-run_detail/{}/log'.format(sr.pk), user='test')








