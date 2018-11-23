from django_webtest import WebTest
from django.urls import reverse
from factory.django import DjangoModelFactory as Dmf
import factory
from .test_factory import TestScenarioFactory, ServerRunFactory


class TestCreation(WebTest):

    def setUp(self):
        TestScenarioFactory()


    def test_creation_list(self):
        call = self.app.get('/server/server-run_list',user='test')
        assert 'no session' in str(call.body)

        call = self.app.get('/server/start_server-run',user='test')
        form = call.forms[1]
        form['test_scenario'].force_value('1')
        form.submit()
        call = self.app.get('/server/server-run_list',user='test')
        assert 'no session' not in str(call.body)

    def test_creation_error_list(self):
        call = self.app.get('/server/server-run_list',user='test')
        assert 'no session' in str(call.body)

        call = self.app.get('/server/start_server-run',user='test')
        form = call.forms[1]
        form['test_scenario'].force_value('9')
        form.submit()
        call = self.app.get('/server/server-run_list',user='test')
        assert 'no session' in str(call.body)




class TestList(WebTest):

    def setUp(self):
        TestScenarioFactory()
        ServerRunFactory()

    def test_list(self):
        call = self.app.get('/server/server-run_list',user='test')
        assert 'no session' not in str(call.body)



