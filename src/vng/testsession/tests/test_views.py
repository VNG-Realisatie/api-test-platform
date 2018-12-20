import collections
import json

from django.urls import reverse
from django.utils import timezone
from django.utils.translation import gettext

from django_webtest import WebTest

from vng.accounts.models import User

from ..models import Session, SessionType, SessionLog
from .factories import (
    SessionFactory, SessionTypeFactory, UserFactory, ScenarioCaseFactory, ExposedUrlFactory, SessionLogFactory)
from ...utils import choices


def get_object(r):
    return json.loads(r.decode('utf-8'))


def get_username():
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
            'session_type': self.session_type.id,
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
            'session_type': self.session_type.id,
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
        self.exp_url.session = self.session
        self.scenarioCase.vng_endpoint = self.exp_url.vng_endpoint
        self.session_log = SessionLogFactory()

    def test_retrieve_no_logged(self):
        call = self.app.get(reverse('testsession:session_log', kwargs={'session_id': self.session.id}), status=302)

    def test_retrieve_no_entries(self):
        call = self.app.get(reverse('testsession:session_log', kwargs={'session_id': self.session.id}), user=self.session.user)
        self.assertTrue('Er zijn geen verzoeken' in call.text)

    def test_retrieve_no_entry(self):
        url = reverse('testsession:run_test', kwargs={
            'exposed_url': self.exp_url.exposed_url,
            'relative_url': self.exp_url.vng_endpoint.url
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
