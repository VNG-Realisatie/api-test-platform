import collections
import json
import copy

from django.urls import reverse
from django.utils import timezone
from django.utils.translation import gettext

from django_webtest import WebTest

from vng.accounts.models import User

from ..models import Session, SessionType, SessionLog, Report
from .factories import (
    SessionFactory, SessionTypeFactory, UserFactory, ScenarioCaseFactory, ExposedUrlFactory, SessionLogFactory, VNGEndpointFactory)
from ...utils import choices


def get_object(r):
    return json.loads(r.decode('utf-8'))


def get_username():
    if len(User.objects.all()) == 0:
        UserFactory()
    return User.objects.all().first().username


class RetrieveSessionType(WebTest):

    def setUp(self):
        SessionTypeFactory()

    def test_retrieve_single_session_types(self):
        call = self.app.get('/api/v1/sessiontypes/', user='admin')
        t = get_object(call.body)
        self.assertTrue(t[0]['id'] > 0)

    def test_retrieve_multiple_session_types(self):
        SessionTypeFactory.create_batch(size=10)
        call = self.app.get('/api/v1/sessiontypes/', user='admin')
        t = json.loads(call.text)
        self.assertTrue(t[9]['id'] > 0)


class AuthorizationTests(WebTest):

    def setUp(self):
        UserFactory()

    def test_check_unauthenticated_testsessions(self):
        self.app.get('/session/v1/testsessions/', expect_errors=True)

    def test_right_login(self):
        call = self.app.post('/api/auth/login/', params=collections.OrderedDict([
            ('username', get_username()),
            ('password', 'password')]))
        self.assertIsNotNone(call.json.get('key'))

    def test_wrong_login(self):
        call = self.app.post(reverse('apiv1_auth:rest_login'), {
            'username': get_username(),
            'password': 'wrong'
        }, status=400)

        self.assertEqual(call.json, {"non_field_errors": [gettext("Unable to log in with provided credentials.")]})

    def test_session_creation_authentication(self):
        Session.objects.all().delete()
        session = {
            'session_type': 1,
            'started': str(timezone.now()),
            'status': choices.StatusChoices.running,
            'api_endpoint': 'http://google.com',
        }
        call = self.app.post('/api/v1/testsessions/', session, status=401)


class CreationAndDeletion(WebTest):

    def setUp(self):
        self.session_type = SessionTypeFactory()
        self.user = UserFactory()

    def test_session_creation(self):
        session = {
            'session_type': self.session_type.name,
            'started': str(timezone.now()),
            'status': choices.StatusChoices.running,
            'api_endpoint': 'http://google.com'
        }
        call = self.app.post('/api/auth/login/', params=collections.OrderedDict([
            ('username', get_username()),
            ('password', 'password')]))
        key = get_object(call.body)['key']
        head = {'Authorization': 'Token {}'.format(key)}
        call = self.app.post(reverse('apiv1:test_session_list'), session, headers=head)

    def test_session_creation_permission(self):
        Session.objects.all().delete()
        session = {
            'session_type': self.session_type.name,
            'started': str(timezone.now()),
            'status': choices.StatusChoices.running,
            'api_endpoint': 'http://google.com',
            'user': self.user.id,
        }

        call = self.app.post('/api/auth/login/', params=collections.OrderedDict([
            ('username', get_username()),
            ('password', 'password')]))
        key = get_object(call.body)['key']
        head = {'Authorization': 'Token {}'.format(key)}
        call = self.app.post(reverse('apiv1:test_session_list'), session, headers=head)
        response_parsed = get_object(call.body)
        session = Session.objects.filter(pk=response_parsed['id'])[0]
        user = User.objects.all().first()
        self.assertEqual(session.user.pk, user.pk)

    def stop_session_no_auth(self):
        session = SessionFactory()
        call = self.app.post(reverse('testsession:stop_session', kwargs={'session_id': session.id}), user=SessionFactory().user, status=403)


class TestLog(WebTest):

    def setUp(self):
        self.scenarioCase = ScenarioCaseFactory()
        self.exp_url = ExposedUrlFactory()
        self.session = self.exp_url.session
        self.exp_url.vng_endpoint.session_type = self.session.session_type
        self.exp_url.exposed_url = '{}/{}'.format(self.exp_url.exposed_url, self.exp_url.vng_endpoint.name)
        self.scenarioCase.vng_endpoint = self.exp_url.vng_endpoint
        self.scenarioCase_hard = copy.copy(self.scenarioCase)
        self.scenarioCase_hard.url = 'test/{uuid}/t'
        self.scenarioCase_hard.pk += 1

        self.scenarioCase_hard.save()
        self.scenarioCase.save()
        self.exp_url.vng_endpoint.save()
        self.exp_url.save()
        self.session_log = SessionLogFactory()

    def test_retrieve_no_logged(self):
        call = self.app.get(reverse('testsession:session_log', kwargs={'session_id': self.session.id}), status=302)

    def test_retrieve_no_entries(self):
        call = self.app.get(reverse('testsession:session_log', kwargs={'session_id': self.session.id}), user=self.session.user)
        self.assertTrue('Er zijn geen verzoeken' in call.text)

    def test_retrieve_no_entry(self):
        url = reverse('testsession:run_test', kwargs={
            'exposed_url': self.exp_url.get_uuid_url(),
            'name': self.exp_url.vng_endpoint.name,
            'relative_url': ''
        })
        call = self.app.get(url, user=self.session.user)
        call2 = self.app.get(reverse('testsession:session_log', kwargs={'session_id': self.session.id}), user=self.session.user)
        self.assertTrue(url in call2.text)

    def test_log_report(self):
        self.test_retrieve_no_entry()
        call = self.app.get(reverse('testsession:session_report', kwargs={'session_id': self.session.id}), user=self.session.user)

    def test_log_report_pdf(self):
        self.test_retrieve_no_entry()
        call = self.app.get(reverse('testsession:session_report-pdf', kwargs={'session_id': self.session.id}), user=self.session.user)

    def test_log_detail_view(self):
        sl = self.session_log
        call = self.app.get(reverse('testsession:session_log-detail',
                                    kwargs={
                                        'session_id': sl.session.id,
                                        'pk': sl.pk}),
                            user=sl.session.user)

    def test_log_detail_view_no_authorized(self):
        sl = self.session_log
        call = self.app.get(reverse('testsession:session_log-detail',
                                    kwargs={
                                        'session_id': sl.session.id,
                                        'pk': sl.id}),
                            status=[302, 401, 403, 404])

    def test_api_session(self):
        call = self.app.post('/api/auth/login/', params=collections.OrderedDict([
            ('username', get_username()),
            ('password', 'password')]))
        key = get_object(call.body)['key']
        head = {'Authorization': 'Token {}'.format(key)}
        call = self.app.post(reverse("apiv1:test_session_list"), params=collections.OrderedDict([
            ('session_type', SessionType.objects.first().name),
        ]), headers=head)
        call = get_object(call.body)
        url = call['exposedurl_set'][0]['exposed_url']
        session_id = call['id']
        call = self.app.get(url)

        call = self.app.get(reverse('apiv1:stop_session', kwargs={'pk': session_id}))
        call = get_object(call.body)
        self.assertEqual(call, [])

        call = self.app.get(reverse('apiv1:result_session', kwargs={'pk': session_id}))
        call = get_object(call.body)
        self.assertEqual(call['result'], 'No scenario cases available')

    def test_hard_matching(self):
        url = reverse('testsession:run_test', kwargs={
            'exposed_url': self.exp_url.get_uuid_url(),
            'name': self.exp_url.vng_endpoint.name,
            'relative_url': 'test/xxx/t'
        })
        call = self.app.get(url, user=self.session.user, status=[404])
        rp = Report.objects.filter(scenario_case=self.scenarioCase_hard)
        self.assertTrue(len(rp) != 0)


class TestLogNewman(WebTest):

    def setUp(self):
        self.scenario_case = ScenarioCaseFactory()
        self.scenario_case1 = ScenarioCaseFactory()
        self.scenario_case1.vng_endpoint = self.scenario_case.vng_endpoint
        self.scenario_case1.save()

        call = self.app.post('/api/auth/login/', params=collections.OrderedDict([
            ('username', get_username()),
            ('password', 'password')]))
        key = get_object(call.body)['key']
        self.head = {'Authorization': 'Token {}'.format(key)}

    def runTest(self):
        call = self.app.post(reverse("apiv1:test_session_list"), params=collections.OrderedDict([
            ('session_type', self.scenario_case.vng_endpoint.session_type.name),
        ]), headers=self.head)
        call = get_object(call.body)
        session_id = call['id']
        url = call['exposedurl_set'][0]['exposed_url']

        call = self.app.get(url)
        call = get_object(call.body)

        call = self.app.get(reverse('apiv1:stop_session', kwargs={'pk': session_id}))
        call = get_object(call.body)
        self.assertEqual(len(call), 2)

        call = self.app.get(reverse('apiv1:result_session', kwargs={'pk': session_id}))
        call = get_object(call.body)
        self.assertEqual(call['result'], 'failed')
