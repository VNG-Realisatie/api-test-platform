from django.utils.encoding import smart_text
from django.core.exceptions import ImproperlyConfigured, ObjectDoesNotExist

from rest_framework import serializers

from .models import *
from .task import execute_test

from ..utils.exceptions import Error400


class TestScenarioUrlSerializer(serializers.ModelSerializer):
    class Meta:
        model = TestScenarioUrl
        fields = ['name']


class EndpointSerializer(serializers.ModelSerializer):

    test_scenario_url = TestScenarioUrlSerializer()
    # name = serializers.StringRelatedField(source='test_scenario_url.name')

    class Meta:
        model = Endpoint
        fields = ['url', 'test_scenario_url']

    def create(self, validated_data):
        try:
            name = validated_data.pop('name')
            url = validated_data['url']
            tsu = TestScenarioUrl.objects.get(name=name, test_scenario=validated_data['server'].test_scenario)
            ep = Endpoint.objects.create(test_scenario_url=tsu, url=url, server_run=validated_data['server'])
            return ep
        except Exception as e:
            raise Error400("The urls names provided do not match")


class ServerRunSerializer(serializers.ModelSerializer):
    endpoints = EndpointSerializer(many=True)

    test_scenario = serializers.SlugRelatedField(
        queryset=TestScenario.objects.all(),
        slug_field='name',
    )

    class Meta:
        model = ServerRun
        fields = [
            'id',
            'test_scenario',
            'started',
            'stopped',
            'client_id',
            'secret',
            'endpoints',
            'status'
        ]
        read_only_fields = ['started', 'stopped', 'status']

    def create(self, validated_data):
        endpoint_created = []
        if 'endpoint_list' in validated_data:
            endpoints = validated_data.pop('endpoint_list')
            validated_data.pop('endpoints')
            instance = ServerRun.objects.create(**validated_data)
            for ep in endpoints:
                if 'test_scenario_url' in ep and 'url' in ep:
                    if 'name' in ep['test_scenario_url']:
                        ep_serializer = EndpointSerializer()
                        endpoint_created.append(ep_serializer.create({
                            'name': ep['test_scenario_url']['name'],
                            'url': ep['url'],
                            'server': instance
                        }))
        else:
            instance = ServerRun.objects.create(**validated_data)
        instance.endpoints = endpoint_created
        execute_test.delay(instance.pk)
        return instance
