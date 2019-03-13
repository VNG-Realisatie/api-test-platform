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
            'url': 'https://ref.tst.vng.cloud/ztc/api/v1/schema/?format=openapi'
        }
        call = self.app.post_json(self.url, payload)
        self.assertIn('200', call.status)
        self.assertEqual(call.json['satisfied'], True)
