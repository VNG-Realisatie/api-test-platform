import collections
import re
import json
import copy

import mock

from django.conf import settings
from django.urls import reverse
from django.utils import timezone
from django.utils.translation import gettext
from subdomains.utils import reverse as reverse_sub

from django_webtest import WebTest

from vng.accounts.models import User

from ..api_views import RunTest
from ..models import Session, SessionType, SessionLog, Report, ScenarioCase, VNGEndpoint, ExposedUrl

from .factories import (
    SessionFactory, SessionTypeFactory, VNGEndpointDockerFactory, ExposedUrlEchoFactory, VNGEndpointEchoFactory,
    ScenarioCaseFactory, ExposedUrlFactory, SessionLogFactory, VNGEndpointFactory, QueryParamsScenarioFactory,
    HeaderInjectionFactory
)
from ...utils import choices
from ...utils.factories import UserFactory


def get_object(r):
    return json.loads(r.decode('utf-8'))


settings.ALLOWED_HOSTS += ['*']


def get_username():
    if len(User.objects.all()) == 0:
        UserFactory()
    return User.objects.all().first().username


def get_subdomain(url):
    return re.search('([0-9]+)\-', url).group(1)


class RetrieveSessionType(WebTest):

    def setUp(self):
        SessionTypeFactory()

    def test_retrieve_single_session_types(self):
        call = self.app.get(reverse('apiv1session:session_types-list'), user='admin')
        t = get_object(call.body)
        self.assertTrue(t[0]['id'] > 0)

    def test_retrieve_multiple_session_types(self):
        SessionTypeFactory.create_batch(size=10)
        call = self.app.get(reverse('apiv1session:session_types-list'), user='admin')
        t = json.loads(call.text)
        self.assertTrue(t[9]['id'] > 0)


class AuthorizationTests(WebTest):

    def setUp(self):
        UserFactory()

    def test_check_unauthenticated_testsessions(self):
        self.app.get(reverse('apiv1session:session_types-list'), expect_errors=True)

    def test_right_login(self):
        call = self.app.post(reverse('apiv1_auth:rest_login'), params=collections.OrderedDict([
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
        call = self.app.post(reverse('apiv1session:test_session-list'), session, status=[401, 302])


class CreationAndDeletion(WebTest):

    def setUp(self):
        self.session_type = SessionTypeFactory()
        self.user = UserFactory()
        self.session_type_docker = VNGEndpointDockerFactory().session_type
        call = self.app.post(reverse('apiv1_auth:rest_login'), params=collections.OrderedDict([
            ('username', get_username()),
            ('password', 'password')]))
        key = get_object(call.body)['key']
        self.head = {'Authorization': 'Token {}'.format(key)}

    def test_session_creation(self):
        session = {
            'session_type': self.session_type.name,
            'api_endpoint': 'http://google.com'
        }

        call = self.app.post(reverse('apiv1session:test_session-list'), session, headers=self.head)

    def test_deploy_docker_via_api(self):
        self.app.post_json(reverse('apiv1session:test_session-list'), {
            'session_type': self.session_type_docker.name
        }, headers=self.head)

    def test_session_creation_permission(self):
        Session.objects.all().delete()
        session = {
            'session_type': self.session_type.name,
            'started': str(timezone.now()),
            'status': choices.StatusChoices.running,
            'api_endpoint': 'http://google.com',
            'user': self.user.id,
        }

        call = self.app.post(reverse('apiv1_auth:rest_login'), params=collections.OrderedDict([
            ('username', get_username()),
            ('password', 'password')]))
        key = get_object(call.body)['key']
        head = {'Authorization': 'Token {}'.format(key)}
        call = self.app.post(reverse('apiv1session:test_session-list'), session, headers=head)
        response_parsed = get_object(call.body)
        session = Session.objects.filter(pk=response_parsed['id'])[0]
        user = User.objects.all().first()
        self.assertEqual(session.user.pk, user.pk)

    def test_stop_session_no_auth(self):
        session = SessionFactory()
        call = self.app.post(reverse('testsession:stop_session', kwargs={'session_id': session.id}), user=SessionFactory().user, status=403)


class TestLog(WebTest):

    def setUp(self):
        self.scenarioCase = ScenarioCaseFactory()
        self.exp_url = ExposedUrlFactory()
        self.session = self.exp_url.session
        self.exp_url.vng_endpoint.session_type = self.session.session_type
        self.scenarioCase.vng_endpoint = self.exp_url.vng_endpoint
        self.scenarioCase_hard = copy.copy(self.scenarioCase)
        self.scenarioCase_hard.url = 'test/{uuid}/t'
        self.scenarioCase_hard.pk += 1

        self.scenarioCase_hard.save()
        self.scenarioCase.save()
        self.exp_url.vng_endpoint.save()
        self.exp_url.save()
        self.session_log = SessionLogFactory()
        self.endpoint_echo_e = ExposedUrlEchoFactory()
        self.endpoint_echo_e.session.session_type = self.endpoint_echo_e.vng_endpoint.session_type
        self.endpoint_echo_e.session.save()
        self.endpoint_echo_e.save()

        self.endpoint_echo_h = ExposedUrlEchoFactory()
        self.endpoint_echo_h.session.session_type = self.endpoint_echo_h.vng_endpoint.session_type
        self.endpoint_echo_h.vng_endpoint.url = 'https://postman-echo.com/headers'
        self.endpoint_echo_h.vng_endpoint.save()
        self.endpoint_echo_h.session.session_type.authentication = choices.AuthenticationChoices.jwt
        self.endpoint_echo_h.session.session_type.save()
        self.endpoint_echo_h.session.save()
        self.endpoint_echo_h.save()

    def test_retrieve_no_logged(self):
        call = self.app.get(reverse('testsession:session_log', kwargs={'session_id': self.session.id}), status=302)

    def test_retrieve_no_entries(self):
        call = self.app.get(reverse('testsession:session_log', kwargs={'session_id': self.session.id}), user=self.session.user)
        self.assertTrue('Er zijn geen verzoeken' in call.text)

    def test_retrieve_no_entry(self):
        url = reverse_sub('serverproxy:run_test', self.exp_url.subdomain, kwargs={
            'relative_url': ''
        })
        call = self.app.get(url, extra_environ={'HTTP_HOST': '{}-example.com'.format(self.exp_url.subdomain)}, user=self.session.user)
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
        call = self.app.post(reverse('apiv1_auth:rest_login'), params=collections.OrderedDict([
            ('username', get_username()),
            ('password', 'password')]))
        key = get_object(call.body)['key']
        head = {'Authorization': 'Token {}'.format(key)}
        call = self.app.post(reverse("apiv1session:test_session-list"), params=collections.OrderedDict([
            ('session_type', SessionType.objects.first().name),
        ]), headers=head)
        call = get_object(call.body)
        url = call['exposedurl_set'][0]['subdomain']
        session_id = call['id']
        http_host = get_subdomain(url)
        call = self.app.get(url, extra_environ={'HTTP_HOST': '{}-example.com'.format(http_host)})
        call = self.app.get(reverse('apiv1session:stop_session', kwargs={'pk': session_id}))
        call = get_object(call.body)
        self.assertEqual(call, [])
        session = Session.objects.get(pk=session_id)
        self.assertEqual(session.status, choices.StatusChoices.stopped)

        call = self.app.get(reverse('apiv1session:result_session', kwargs={'pk': session_id}))
        call = get_object(call.body)
        self.assertEqual(call['result'], 'No scenario cases available')

    def test_hard_matching(self):
        url = reverse_sub('serverproxy:run_test', self.exp_url.subdomain, kwargs={
            'relative_url': 'test/xxx/t'
        })
        call = self.app.get(url, extra_environ={'HTTP_HOST': '{}-example.com'.format(self.exp_url.subdomain)}, user=self.session.user, status=[404])
        rp = Report.objects.filter(scenario_case=self.scenarioCase_hard)
        self.assertTrue(len(rp) != 0)

    def test_exposed_urls(self):
        call = self.app.get(reverse("apiv1session:test_session-list"), user=self.session.user)
        res = call.json
        session = Session.objects.get(id=res[0]['id'])
        endpoint = VNGEndpoint.objects.get(name=res[0]['exposedurl_set'][0]['vng_endpoint'])
        self.assertEqual(endpoint.session_type, session.session_type)

    def test_ordered_report(self):
        url = reverse('testsession:session_report', kwargs={
            'session_id': self.session.id
        })
        sc = ScenarioCase.objects.filter(vng_endpoint__session_type=self.session.session_type).order_by('order')
        call = self.app.get(url, user=self.session.user)
        index = 0
        for s in sc:
            index = call.text[index:].index(s.url) + 2

    @mock.patch('vng.testsession.api_views.logger')
    def test_rewrite_body(self, mock_logger):
        url = reverse_sub('serverproxy:run_test', self.endpoint_echo_e.subdomain, kwargs={
            'relative_url': 'post/'
        })
        call = self.app.post(url, url, extra_environ={'HTTP_HOST': '{}-example.com'.format(self.endpoint_echo_e.subdomain)}, user=self.endpoint_echo_e.session.user)
        self.assertIn('Rewriting request body:', mock_logger.info.call_args_list[-7][0][0])
        self.assertIn(url, call.text)

    def test_no_rewrite_header(self):
        url = reverse_sub('serverproxy:run_test', self.endpoint_echo_h.subdomain, kwargs={
            'relative_url': ''
        })
        headers = {'authorization': 'dummy'}
        call = self.app.get(url, extra_environ={'HTTP_HOST': '{}-example.com'.format(self.endpoint_echo_h.subdomain)},
                            headers=headers, user=self.endpoint_echo_h.session.user)
        self.assertEqual(call.json['headers']['authorization'], headers['authorization'])


class TestUrlParam(WebTest):

    def setUp(self):
        self.qp = QueryParamsScenarioFactory()
        self.scenario_case = self.qp.scenario_case
        self.vng_endpoint = self.scenario_case.vng_endpoint
        self.session = SessionFactory(session_type=self.vng_endpoint.session_type)
        self.exposed_url = ExposedUrlFactory(session=self.session, vng_endpoint=self.vng_endpoint)
        self.qp_p = QueryParamsScenarioFactory()
        self.scenario_case_p = self.qp_p.scenario_case
        self.scenario_case_p.http_method = choices.HTTPMethodChoiches.PUT
        self.scenario_case_p.save()
        self.vng_endpoint_p = self.scenario_case_p.vng_endpoint
        self.session_p = SessionFactory(session_type=self.vng_endpoint_p.session_type)
        self.exposed_url_p = ExposedUrlFactory(session=self.session_p, vng_endpoint=self.vng_endpoint_p)

    def test_query_params_no_match(self):
        report = len(Report.objects.filter(scenario_case=self.scenario_case))
        url = reverse_sub('serverproxy:run_test', self.exposed_url.subdomain, kwargs={
            'relative_url': self.scenario_case.url
        })
        call = self.app.get(url, extra_environ={'HTTP_HOST': '{}-example.com'.format(self.exposed_url.subdomain)},
                            user=self.session.user, status=[404])
        self.assertEqual(report, len(Report.objects.filter(scenario_case=self.scenario_case)))

    def test_query_params_match_wild(self):
        report = len(Report.objects.filter(scenario_case=self.scenario_case))
        url = reverse_sub('serverproxy:run_test', self.exposed_url.subdomain, kwargs={
            'relative_url': self.scenario_case.url
        })
        call = self.app.get(url,
                            {self.qp.name: 'dummy'},
                            extra_environ={'HTTP_HOST': '{}-example.com'.format(self.exposed_url.subdomain)},
                            user=self.session.user, status=[404]
                            )
        self.assertEqual(report + 1, len(Report.objects.filter(scenario_case=self.scenario_case)))

    def test_query_params_match(self):
        qp = QueryParamsScenarioFactory(scenario_case=self.scenario_case, expected_value='dummy', name='strict')
        report = len(Report.objects.filter(scenario_case=self.scenario_case))
        url = reverse_sub('serverproxy:run_test', self.exposed_url.subdomain, kwargs={
            'relative_url': self.scenario_case.url
        })
        call = self.app.get(url,
                            {'strict': 'dummy', self.qp.name: 'dummy'},
                            extra_environ={'HTTP_HOST': '{}-example.com'.format(self.exposed_url.subdomain)},
                            user=self.session.user, status=[404]
                            )
        self.assertEqual(report + 1, len(Report.objects.filter(scenario_case=self.scenario_case)))

    def test_query_params_put(self):
        report = len(Report.objects.filter(scenario_case=self.scenario_case_p))
        url = reverse_sub('serverproxy:run_test', self.exposed_url_p.subdomain, kwargs={
            'relative_url': self.scenario_case_p.url
        })
        call = self.app.put(url + '?{}=dummy'.format(self.qp_p.name),
                            extra_environ={'HTTP_HOST': '{}-example.com'.format(self.exposed_url_p.subdomain)},
                            user=self.session_p.user, status=[404]
                            )
        self.assertEqual(report + 1, len(Report.objects.filter(scenario_case=self.scenario_case_p)))


class TestUrlMatchingPatterns(WebTest):

    def setUp(self):
        self.scenario_case = ScenarioCaseFactory(url='test')

        call = self.app.post(reverse('apiv1_auth:rest_login'), params=collections.OrderedDict([
            ('username', get_username()),
            ('password', 'password')]))
        key = get_object(call.body)['key']
        self.head = {'Authorization': 'Token {}'.format(key)}

    def test_create_session(self):
        # Save the report list
        report_list = Report.objects.all()
        resp = self.app.post_json(reverse('apiv1session:test_session-list'), {
            'session_type': self.scenario_case.vng_endpoint.session_type.name
        }, headers=self.head)

        # Call the url with additional padding
        http_host = get_subdomain(resp.json['exposedurl_set'][0]['subdomain'])
        self.app.get(resp.json['exposedurl_set'][0]['subdomain'] + 'test' + '/dummy',
                     extra_environ={'HTTP_HOST': '{}-example.com'.format(http_host)}, expect_errors=True)
        # Check that the report has not been crated
        self.assertEqual(len(report_list), len(Report.objects.all()))

        # Call the url without further padding
        self.app.get(resp.json['exposedurl_set'][0]['subdomain'] + 'test',
                     extra_environ={'HTTP_HOST': '{}-example.com'.format(http_host)}, expect_errors=True)
        # Check if the report has been created
        self.assertEqual(len(report_list) + 1, len(Report.objects.all()))

        last_report = Report.objects.latest('id')
        self.assertEqual(last_report.scenario_case, self.scenario_case)


class TestSandboxMode(WebTest):

    def setUp(self):
        self.user = UserFactory()
        self.sc = ScenarioCaseFactory(url='status/{code}')
        self.sc.vng_endpoint.url = 'https://postman-echo.com/'
        self.sc.vng_endpoint.save()

    def test_sandbox(self):
        call = self.app.get(reverse('testsession:sessions'), user=self.user)
        form = call.forms[0]
        form['session_type'].select(form['session_type'].options[-1][0])
        form['sandbox'] = True
        form.submit()
        session = Session.objects.all().order_by('-pk')[0]
        eu = ExposedUrl.objects.get(session=session)

        all_rep = Report.objects.all()
        url = reverse_sub('serverproxy:run_test', eu.subdomain, kwargs={
            'relative_url': 'status/404'
        })
        call = self.app.get(url, extra_environ={'HTTP_HOST': '{}-example.com'.format(eu.subdomain)}, user=session.user, status=[404])
        report = Report.objects.get(scenario_case=self.sc)

        self.assertEqual(choices.HTTPCallChoiches.failed, report.result)
        url = reverse_sub('serverproxy:run_test', eu.subdomain, kwargs={
            'relative_url': 'status/200'
        })
        call = self.app.get(url, extra_environ={'HTTP_HOST': '{}-example.com'.format(eu.subdomain)}, user=session.user)
        report = Report.objects.get(scenario_case=self.sc)
        self.assertEqual(choices.HTTPCallChoiches.success, report.result)

    def test_no_sandbox(self):
        call = self.app.get(reverse('testsession:sessions'), user=self.user)
        form = call.forms[0]
        form['session_type'].select(form['session_type'].options[-1][0])
        form['sandbox'] = False
        form.submit()
        session = Session.objects.all().order_by('-pk')[0]
        eu = ExposedUrl.objects.get(session=session)

        all_rep = Report.objects.all()
        url = reverse_sub('serverproxy:run_test', eu.subdomain, kwargs={
            'relative_url': 'status/404'
        })
        call = self.app.get(url, extra_environ={'HTTP_HOST': '{}-example.com'.format(eu.subdomain)}, user=session.user, status=[404])
        report = Report.objects.get(scenario_case=self.sc)

        self.assertEqual(choices.HTTPCallChoiches.failed, report.result)
        url = reverse_sub('serverproxy:run_test', eu.subdomain, kwargs={
            'relative_url': 'status/200'
        })
        call = self.app.get(url, extra_environ={'HTTP_HOST': '{}-example.com'.format(eu.subdomain)}, user=session.user)
        report = Report.objects.get(scenario_case=self.sc)
        self.assertEqual(choices.HTTPCallChoiches.failed, report.result)


class TestAllProcedure(WebTest):
    csrf_checks = False

    def setUp(self):
        self.user = UserFactory()
        self.session_type = SessionTypeFactory()

    def _test_create_session(self):
        call = self.app.get(reverse('testsession:sessions'), user=self.user)
        form = call.forms[0]
        form['session_type'].select('1')
        form.submit()

        call = self.app.get(reverse('testsession:sessions'), user=self.user)
        self.assertIn(self.session_type.name, call.text)

    def _test_stop_session(self):
        self._test_create_session()
        self.session = Session.objects.filter(user=self.user).filter(status=choices.StatusChoices.running)[0]
        url = reverse('testsession:stop_session', kwargs={
            'session_id': self.session.pk,
        })
        call = self.app.post(url, user=self.session.user).follow()
        self.assertIn('stopped', call.text)

    def test_report(self):
        self._test_create_session()
        self._test_stop_session()
        session = Session.objects.get(pk=self.session.pk)
        url = reverse('testsession:session_report', kwargs={
            'session_id': self.session.pk,
        })
        call = self.app.get(url, user=self.session.user)

        url = reverse('testsession:session_report-pdf', kwargs={
            'session_id': self.session.pk,
        })
        call = self.app.get(url, user=self.session.user)


class TestLogNewman(WebTest):

    def setUp(self):
        self.scenario_case = ScenarioCaseFactory()
        self.scenario_case1 = ScenarioCaseFactory()
        self.scenario_case1.vng_endpoint = self.scenario_case.vng_endpoint
        self.scenario_case1.save()

        call = self.app.post(reverse('apiv1_auth:rest_login'), params=collections.OrderedDict([
            ('username', get_username()),
            ('password', 'password')]))
        key = get_object(call.body)['key']
        self.head = {'Authorization': 'Token {}'.format(key)}

    def test_run(self):
        call = self.app.post(reverse("apiv1session:test_session-list"), params=collections.OrderedDict([
            ('session_type', self.scenario_case.vng_endpoint.session_type.name),
        ]), headers=self.head)
        call = get_object(call.body)
        session_id = call['id']
        url = call['exposedurl_set'][0]['subdomain']

        http_host = get_subdomain(call['exposedurl_set'][0]['subdomain'])
        call = self.app.get(url, extra_environ={'HTTP_HOST': '{}-example.com'.format(http_host)})
        call = get_object(call.body)

        call = self.app.get(reverse('apiv1session:stop_session', kwargs={'pk': session_id}))
        call = get_object(call.body)
        self.assertEqual(len(call), 2)

        call = self.app.get(reverse('apiv1session:result_session', kwargs={'pk': session_id}))
        call = get_object(call.body)
        self.assertEqual(call['result'], 'failed')


class TestHeaderInjection(WebTest):

    def setUp(self):
        self.endpoint = VNGEndpointEchoFactory()
        self.hi = HeaderInjectionFactory(session_type=self.endpoint.session_type)

        call = self.app.post(reverse('apiv1_auth:rest_login'), params=collections.OrderedDict([
            ('username', get_username()),
            ('password', 'password')]))
        key = get_object(call.body)['key']
        self.head = {'Authorization': 'Token {}'.format(key)}

    def test_run(self):
        call = self.app.post(reverse("apiv1session:test_session-list"), params=collections.OrderedDict([
            ('session_type', self.endpoint.session_type.name),
        ]), headers=self.head)
        call = get_object(call.body)
        session_id = call['id']
        url = call['exposedurl_set'][0]['subdomain']

        http_host = get_subdomain(call['exposedurl_set'][0]['subdomain'])
        call = self.app.get(url + 'headers', extra_environ={'HTTP_HOST': '{}-example.com'.format(http_host)})
        self.assertIn('key', call.json['headers'])
        self.assertIn('dummy', call.json['headers']['key'])


class TestAuthProxy(WebTest):

    def setUp(self):
        self.user = UserFactory()
        self.vng_no_auth = VNGEndpointEchoFactory()
        self.vng_auth = VNGEndpointEchoFactory()
        self.vng_header = VNGEndpointEchoFactory()
        self.vng_auth.session_type.authentication = choices.AuthenticationChoices.jwt
        self.vng_auth.session_type.save()
        self.vng_header.session_type.authentication = choices.AuthenticationChoices.header
        self.vng_header.session_type.header = 'test'
        self.vng_header.session_type.save()

        call = self.app.post(reverse('apiv1_auth:rest_login'), params=collections.OrderedDict([
            ('username', get_username()),
            ('password', 'password')]))
        key = get_object(call.body)['key']
        self.head = {'Authorization': 'Token {}'.format(key)}

        self.url_no_auth = self.app.post(reverse("apiv1session:test_session-list"), params=collections.OrderedDict([
            ('session_type', self.vng_no_auth.session_type.name),
        ]), headers=self.head).json['exposedurl_set'][0]['subdomain']

        self.url_auth = self.app.post(reverse("apiv1session:test_session-list"), params=collections.OrderedDict([
            ('session_type', self.vng_auth.session_type.name),
        ]), headers=self.head).json['exposedurl_set'][0]['subdomain']

        self.url_head = self.app.post(reverse("apiv1session:test_session-list"), params=collections.OrderedDict([
            ('session_type', self.vng_header.session_type.name),
        ]), headers=self.head).json['exposedurl_set'][0]['subdomain']

    def test_no_auth(self):
        http_host = get_subdomain(self.url_no_auth)
        resp = self.app.post(self.url_no_auth + 'post', extra_environ={'HTTP_HOST': '{}-example.com'.format(http_host)})
        self.assertNotIn('authorization', resp.json['headers'])

    def test_auth(self):
        http_host = get_subdomain(self.url_auth)
        resp = self.app.post(self.url_auth + 'post', extra_environ={'HTTP_HOST': '{}-example.com'.format(http_host)})
        self.assertIn('authorization', resp.json['headers'])

    def test_header(self):
        http_host = get_subdomain(self.url_head)
        resp = self.app.post(self.url_head + 'post', extra_environ={'HTTP_HOST': '{}-example.com'.format(http_host)})
        self.assertEqual('test', resp.json['headers']['authorization'])


class TestRewriteBody(WebTest):

    def setUp(self):
        self.euv = RunTest()
        self.ep = ExposedUrlFactory()
        self.ep_docker = VNGEndpointDockerFactory()
        self.ep_d = ExposedUrlFactory(vng_endpoint=self.ep_docker, docker_url='127.0.0.1')
        self.host = 'example.com'

    def test_request(self):
        content = 'dummy{}/dummy'.format(self.host)
        res = self.euv.sub_url_request(content, self.host, self.ep)
        self.assertEqual('dummy{}/dummy'.format(self.ep.vng_endpoint.url), res)

    def test_response(self):
        content = 'dummy{}/dummy'.format(self.ep.vng_endpoint.url)
        res = self.euv.sub_url_response(content, self.host, self.ep)
        print(res)
        self.assertEqual('dummy{}/dummy'.format(self.host), res)

    def test_request_docker(self):
        content = 'dummy{}/dummy'.format(self.host)
        res = self.euv.sub_url_request(content, self.host, self.ep_d)
        self.assertEqual('dummy://{}:8080/dummy'.format(self.ep_d.docker_url), res)

    def test_response_docker(self):
        content = 'dummy://{}:8080/dummy'.format(self.ep_d.docker_url)
        res = self.euv.sub_url_response(content, self.host, self.ep_d)
        self.assertEqual('dummy{}/dummy'.format(self.host), res)


class TestRewriteUrl(WebTest):

    def setUp(self):
        self.endpoint = VNGEndpointFactory(url='http://www.dummy.com/path/sub/')
        self.eu = ExposedUrlFactory(vng_endpoint=self.endpoint)

    def test_url(self):
        rt = RunTest()
        rt.kwargs = {
            'relative_url': ''
        }
        url = rt.build_url(self.eu, '')
        self.assertEqual(url, self.endpoint.url)

    def test_url_sub(self):
        rt = RunTest()
        rt.kwargs = {
            'relative_url': 'path/'
        }
        url = rt.build_url(self.eu, '')
        self.assertEqual(url, 'http://www.dummy.com/path/')

    def test_url_sub_sub(self):
        rt = RunTest()
        rt.kwargs = {
            'relative_url': 'path/sub/a'
        }
        url = rt.build_url(self.eu, '')
        self.assertEqual(url, 'http://www.dummy.com/path/sub/a')
