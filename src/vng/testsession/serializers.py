from rest_framework import serializers
from django.urls import reverse

from .models import *


class SessionTypesSerializer(serializers.ModelSerializer):
    class Meta:
        model = SessionType
        fields = ['id', 'name', 'standard', 'role', 'application', 'version']


class ExposedUrlSerializer(serializers.ModelSerializer):
    vng_endpoint = serializers.StringRelatedField(read_only=True)

    class Meta:
        model = ExposedUrl
        fields = ['id', 'exposed_url', 'session', 'vng_endpoint']

    def to_representation(self, value):
        v = super().to_representation(value)
        request = self.context['request']
        host = 'http://{}'.format(request.get_host())
        v['exposed_url'] = '{}{}'.format(
            host,
            reverse('testsession:run_test', kwargs={
                    'exposed_url': value.exposed_url,
                    'relative_url': ''
                    })
        )
        return v


class SessionSerializer(serializers.ModelSerializer):
    exposedurl_set = ExposedUrlSerializer(read_only=True, many=True)

    class Meta:
        model = Session
        fields = [
            'id',
            'session_type',
            'started',
            'stopped',
            'status',
            'exposedurl_set',
        ]


class ScenarioCaseSerializer(serializers.ModelSerializer):
    report_set = serializers.SlugRelatedField(
        slug_field='result',
        many=True,
        read_only=True,
    )

    class Meta:
        model = ScenarioCase
        fields = ['url', 'http_method', 'vng_endpoint', 'report_set']
