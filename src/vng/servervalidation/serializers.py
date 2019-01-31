from .models import *
from rest_framework import serializers


class EndpointSerializer(serializers.ModelSerializer):
    class Meta:
        model = Endpoint
        fields = ['url', 'jwt']


class TestScenarioSerializer(serializers.ModelSerializer):
    class Meta:
        model = TestScenario
        fields = ['name', 'validation_file']


class ServerRunSerializer(serializers.ModelSerializer):
    # endpoint_queryset = Endpoint.obejcts.filter()
    endpoints = EndpointSerializer(many=True, read_only=True)
    # TODO: output of the test_scenario of its name, not the foreign key

    class Meta:
        model = ServerRun
        fields = ['id', 'test_scenario', 'started', 'stopped', 'client_id', 'client_id', 'endpoints']


class TestScenarioUrlSerializer(serializers.ModelSerializer):
    class Meta:
        model = TestScenarioUrl
        fields = ['name', 'test_scenario']
