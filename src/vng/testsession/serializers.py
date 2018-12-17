from .models import *
from rest_framework import serializers


class SessionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Session
        fields = ['id', 'session_type', 'started', 'stopped', 'status', 'api_endpoint']


class SessionTypesSerializer(serializers.ModelSerializer):
    class Meta:
        model = SessionType
        fields = ['id', 'name', 'standard', 'role', 'application', 'version']


# class VNGEndpointSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = VNGEndpoint
#         fields = ['id', 'name', 'url', 'docker_image', 'sessio_type']
