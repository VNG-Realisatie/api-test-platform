import factory
from django_webtest import WebTest
from django.urls import reverse
from factory.django import DjangoModelFactory as Dmf
from vng.testsession.tests.factories import UserFactory
from .factories import TestScenarioFactory, ServerRunFactory, TestScenarioUrlFactory, PostmanTestFactory
from vng.servervalidation.models import ServerRun


class TestCreation(WebTest):

    def setUp(self):
        self.tsf = TestScenarioUrlFactory().test_scenario
        self.pt = PostmanTestFactory()
        self.test_scenario = self.tsf
        self.pt.save()
        self.server = ServerRunFactory()
        self.user = UserFactory()
        self.server.user = self.user
        self.server.save()

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

    def test_postman_outcome(self):
        server = ServerRun.objects.filter(user=self.user).order_by('-started')[0]
        url = reverse('server_run:server-run_detail', kwargs={
            'pk': server.pk
        })
        call = self.app.get(url, user=self.user)
        self.assertIn(str(server.pk), call.text)


class TestList(WebTest):

    def setUp(self):
        TestScenarioFactory()
        ServerRunFactory()

    def test_list(self):
        call = self.app.get(reverse('server_run:server-run_list'), user='test')
        assert 'no session' not in str(call.body)
