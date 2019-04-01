from rest_framework import serializers
from django.urls import reverse
from django.conf import settings

from .models import SessionType, ExposedUrl, Session, ScenarioCase


class SessionTypesSerializer(serializers.ModelSerializer):

    class Meta:
        model = SessionType
        fields = [
            'id',
            'name',
            'standard',
            'role',
            'application',
            'version',
            'authentication',
        ]


class ExposedUrlSerializer(serializers.ModelSerializer):

    vng_endpoint = serializers.SlugRelatedField(
        read_only=True,
        slug_field='name'
    )

    class Meta:
        model = ExposedUrl
        fields = ['id', 'exposed_url', 'session', 'vng_endpoint']

    def to_representation(self, value):
        v = super().to_representation(value)
        request = self.context['request']
        if settings.DEBUG:
            host = 'http://{}'.format(request.get_host())
        else:
            host = 'https://{}'.format(request.get_host())

        v['exposed_url'] = '{}{}'.format(
            host,
            reverse(
                'testsession:run_test', kwargs={
                    'exposed_url': value.get_uuid_url(),
                    'name': value.vng_endpoint.name,
                    'relative_url': ''
                }
            )
        )
        return v


class SessionStatusSerializer(serializers.ModelSerializer):

    class Meta:
        model = Session
        fields = [
            'id',
            'session_type',
            'started',
            'stopped',
            'status',
            'deploy_status',
            'deploy_percentage'
        ]


class SessionSerializer(serializers.ModelSerializer):

    exposedurl_set = ExposedUrlSerializer(read_only=True, many=True)
    build_version = serializers.CharField(required=False)

    session_type = serializers.SlugRelatedField(
        slug_field='name',
        queryset=SessionType.objects.all(),
    )

    class Meta:
        model = Session
        fields = [
            'id',
            'session_type',
            'started',
            'stopped',
            'status',
            'exposedurl_set',
            'build_version'
        ]
        read_only_fields = ['started', 'stopped', 'status']


class ScenarioCaseSerializer(serializers.ModelSerializer):

    class Meta:
        model = ScenarioCase
        fields = ['url', 'http_method', 'vng_endpoint']
