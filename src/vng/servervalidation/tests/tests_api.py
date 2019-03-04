import collections
import json

from django.utils import timezone
from django.test import TestCase
from django_webtest import WebTest
from django.urls import reverse

from vng.accounts.models import User

from ..models import PostmanTestResult
from .factories import ServerRunFactory, TestScenarioFactory, TestScenarioUrlFactory, PostmanTestFactory


def get_object(r):
    return json.loads(r.decode('utf-8'))


def get_username():
    return User.objects.all().first().username


class RetrieveCreationTest(WebTest):

    def setUp(self):
        self.test_scenario = PostmanTestFactory().test_scenario
        self.server = ServerRunFactory()
        tsu1 = TestScenarioUrlFactory()
        tsu2 = TestScenarioUrlFactory()
        tsu1.test_scenario = self.test_scenario
        tsu2.test_scenario = self.test_scenario
        tsu1.save()
        tsu2.save()
        self.server_run = {
            'test_scenario': self.test_scenario.name,
            'client_id': 'client_id_field',
            'secret': 'secret_field',
            'endpoints': [
                {
                    "test_scenario_url": {
                        "name": tsu1.name
                    },
                    'url': 'https://google.com',
                }, {
                    "test_scenario_url": {
                        "name": tsu2.name
                    },
                    'url': 'https://google2.com',
                }
            ]
        }

    def get_user_key(self):
        call = self.app.post('/api/auth/login/', params=collections.OrderedDict([
            ('username', get_username()),
            ('password', 'password')]))
        key = get_object(call.body)['key']
        head = {'Authorization': 'Token {}'.format(key)}
        return head

    def test_unauthenticated_user(self):
        call = self.app.get(reverse('apiv1session:session_types-list'), expect_errors=True)

    def test_creation_server_run(self):
        call = self.app.post_json(reverse('apiv1server:provider:api_server-run-list'), self.server_run, headers=self.get_user_key())

    def test_full_stack(self):
        call = self.app.post_json(reverse('apiv1server:provider:api_server-run-list'), self.server_run, headers=self.get_user_key())
        call = call.json
        self.assertEqual(call['secret'], self.server_run['secret'])
        self.server_run['pk'] = call['id']
        call = self.app.get(reverse('apiv1server:provider:api_server-run-detail', kwargs={
            'pk': self.server_run['pk']
        }), headers=self.get_user_key())
        call = call.json
        self.assertEqual(call['status'], 'stopped')
        call = self.app.get(reverse('apiv1server:provider_result', kwargs={
            'pk': self.server_run['pk']
        }), headers=self.get_user_key())
        ptr = PostmanTestResult.objects.filter(postman_test__test_scenario=self.test_scenario.pk).first()
        self.assertEqual(call.json[0]['status'], ptr.status)

    def test_retrieve_server_run(self):
        headers = self.get_user_key()
        call = self.app.post_json(reverse('apiv1server:provider:api_server-run-list'), self.server_run, headers=headers)
        parsed = get_object(call.body)
        call = self.app.get(reverse('apiv1server:provider:api_server-run-detail', kwargs={'pk': parsed['id']}).format(parsed['id']), headers=headers)

    def test_data_integrity(self):
        fake_pk = 999

        call = self.app.post_json(reverse('apiv1server:provider:api_server-run-list'), self.server_run, headers=self.get_user_key())
        parsed = get_object(call.body)
        self.assertNotEqual(parsed['id'], fake_pk)

    def test_creation_server_run_auth(self):
        call = self.app.post_json(reverse('apiv1server:provider:api_server-run-list'), self.server_run, expect_errors=True)
