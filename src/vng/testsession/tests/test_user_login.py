from django_webtest import WebTest
from django.urls import reverse
from ..models import SessionType,Session

class TestCaseBase(WebTest):

    def test(self):
        index = self.app.get('/')
        assert index.status == '200 OK'


class TestAuth(WebTest):

    def test(self):
        call = self.app.get('/session/sessions/')
        assert call.status != '200 OK'
        call = self.app.get('/session/sessions/',user='test')
        assert call.status == '200 OK'
        

class SessionCreation(WebTest):

    def test(self):
        SessionType(name='test_type',docker_image='di').save()
        call = self.app.get('/session/start-session/',user='admin')
        form = call.forms[1]
        form['type_session'].select(value='1')
        response = form.submit()
        call = self.app.get('/session/sessions/',user='admin')
        assert 'no session' not in str(call.body)
        
class MultipleSessionCreation(WebTest):

    def test(self):
        n_sess = 10
        SessionType(name='test_type',docker_image='di').save()
        for i in range(n_sess):
            call = self.app.get('/session/start-session/',user='admin')
            form = call.forms[1]
            form['type_session'].select(value='1')
            response = form.submit()
        call = self.app.get('/session/sessions/',user='admin')
        assert str(call.body).count('<tr>') == n_sess+1
