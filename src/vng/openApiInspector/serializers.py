from rest_framework import serializers


class OpenApiInspectionSerializer(serializers.Serializer):
    url = serializers.URLField()
