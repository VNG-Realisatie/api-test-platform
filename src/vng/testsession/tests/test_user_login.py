from django_webtest import WebTest
from django.urls import reverse
from factory.django import DjangoModelFactory as Dmf
import factory
from .factories import SessionTypeFactory
from ..models import SessionType, Session


class TestCaseBase(WebTest):

    def test(self):
        call = self.app.get('/')
        self.assertEqual(call.status, '302 Found')


class TestAuth(WebTest):

    def test(self):
        call = self.app.get('/')
        self.assertNotEqual(call.status, '200 OK')
        call = self.app.get('/', user='test')
        self.assertEqual(call.status, '200 OK')


class SessionCreation(WebTest):

    def setUp(self):
        SessionTypeFactory()

    def test(self):
        call = self.app.get(reverse('testsession:session_create'), user='admin')
        self.app.reset()
        form = call.forms[0]
        form['session_type'].force_value(value='1')
        response = form.submit(expect_errors=True)

    def test2(self):
        call = self.app.get(reverse('testsession:session_create'), user='admin')
        form = call.forms[0]
        form['session_type'] = '1'
        form.submit()
        call = self.app.get('/', user='admin')
        assert 'no session' not in str(call.body)

    def test3(self):
        SessionTypeFactory()
        call = self.app.get(reverse('testsession:session_create'), user='admin')
        form = call.forms[0]
        form.submit(expect_errors=True)

    def test4(self):
        call = self.app.get(reverse('testsession:session_create'), user='admin')
        form = call.forms[0]
        form['session_type'].force_value('2')
        form.submit(expect_errors=True)
