from rest_framework import serializers

from .models import *
from .exceptions import Error400


class EndpointSerializer(serializers.ModelSerializer):

    name = serializers.StringRelatedField(source='test_scenario_url.name')

    class Meta:
        model = Endpoint
        fields = ['url', 'name']

    def create(self, validated_data):
        try:
            name = validated_data['name']
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
        slug_field='name'
    )

    class Meta:
        model = ServerRun
        fields = ['id', 'test_scenario', 'started', 'stopped', 'client_id', 'secret', 'endpoints']

    def create(self, validated_data):
        endpoint_created = []
        if 'endpoint_list' in validated_data:
            endpoints = validated_data.pop('endpoint_list')
            validated_data.pop('endpoints')
            instance = ServerRun.objects.create(**validated_data)
            for ep in endpoints:
                ep_serializer = EndpointSerializer()
                endpoint_created.append(ep_serializer.create({
                    'name': ep['name'],
                    'url': ep['url'],
                    'server': instance
                }))
        else:
            instance = ServerRun.objects.create(**validated_data)
        instance.endpoints = endpoint_created
        return instance


class TestScenarioUrlSerializer(serializers.ModelSerializer):
    class Meta:
        model = TestScenarioUrl
        fields = ['name', 'test_scenario']
