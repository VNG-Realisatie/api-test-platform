from django_webtest import WebTest
from django.urls import reverse


class TestOpenApiInspector(WebTest):

    def setUp(self):
        self.url = reverse('apiv1inspector:openAPIinspection')

    def test_invalid_url(self):
        payload = {
            'url': 'invalid url'
        }
        call = self.app.post_json(self.url, payload, expect_errors=True)
        self.assertIn('400', call.status)

    def test_non_reachable_url(self):
        payload = {
            'url': 'www.invalid.commoc'
        }
        call = self.app.post_json(self.url, payload, expect_errors=True)
        self.assertIn('400', call.status)

    def test_non_json_schema(self):
        payload = {
            'url': 'www.google.com'
        }
        call = self.app.post_json(self.url, payload, expect_errors=True)
        self.assertIn('400', call.status)

    def test_success(self):
        payload = {
            'url': 'https://ref.tst.vng.cloud/ztc/api/v1/schema/openapi.json?v=3'
        }
        call = self.app.post_json(self.url, payload)
        self.assertIn('200', call.status)
        self.assertEqual(call.json['satisfied'], True)

    def test_view(self):
        call = self.app.get(reverse('open_api_inspector:openapi-inspection'))
        form = call.forms[0]
        form['url'] = 'https://ref.tst.vng.cloud/ztc/api/v1/schema/openapi.json?v=3'
        call = form.submit().follow()
        self.assertIn("Resultaat", call.text)
        self.assertIn("icon--checkmark", call.text)

    def test_view_error(self):
        call = self.app.get(reverse('open_api_inspector:openapi-inspection'))
        form = call.forms[0]
        form['url'] = 'tss'
        call = form.submit()
        self.assertIn("Voer een geldige URL in", call.text)

    def test_view_error1(self):
        call = self.app.get(reverse('open_api_inspector:openapi-inspection'))
        form = call.forms[0]
        form['url'] = 'http://google.com'
        call = form.submit()
        self.assertIn("The link provided does not contain a json schema", call.text)

    def test_view_error2(self):
        call = self.app.get(reverse('open_api_inspector:openapi-inspection'))
        form = call.forms[0]
        form['url'] = 'https://test.cc.co'
        call = form.submit()
        self.assertIn("The link provided is not reachable", call.text)
