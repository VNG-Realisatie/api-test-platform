from rest_framework import serializers
from django.urls import reverse

from .models import *


class SessionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Session
        fields = [
            'id',
            'session_type',
            'started',
            'stopped',
            'status',
            'session_type',
        ]


class SessionTypesSerializer(serializers.ModelSerializer):
    class Meta:
        model = SessionType
        fields = ['id', 'name', 'standard', 'role', 'application', 'version']


class ExposedUrlSerializer(serializers.ModelSerializer):
    class Meta:
        model = ExposedUrl
        fields = ['id', 'exposed_url', 'session']

    def to_representation(self, value):
        v = super().to_representation(value)
        request = self.context['request']
        host = 'https://{}'.format(request.get_host())
        v['exposed_url'] = '{}{}'.format(
            host,
            reverse('testsession:run_test', kwargs={
                    'exposed_url': value.exposed_url,
                    'relative_url': ''
                    })
        )
        return v

# class VNGEndpointSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = VNGEndpoint
#         fields = ['id', 'name', 'url', 'docker_image', 'sessio_type']
