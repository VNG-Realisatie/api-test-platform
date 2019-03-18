from json.decoder import JSONDecodeError

from drf_yasg.utils import swagger_auto_schema
from rest_framework.exceptions import bad_request, APIException
from rest_framework import views, status
from django.utils.encoding import force_text
from rest_framework.response import Response

from .serializers import OpenApiInspectionSerializer, OpenApiInspectionResponseSerializer

from .utils import openAPIInspector


class OpenAPIValidationException(APIException):

    status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
    default_detail = 'A server error occurred.'

    def __init__(self, detail, field, status_code):
        if status_code is not None:
            self.status_code = status_code
        if detail is not None:
            self.detail = {field: force_text(detail)}
        else:
            self.detail = {'detail': force_text(self.default_detail)}


class OpenApiInspectionAPIView(views.APIView):

    @swagger_auto_schema(request_body=OpenApiInspectionSerializer, responses={200: OpenApiInspectionResponseSerializer})
    def post(self, request):
        serializer = OpenApiInspectionSerializer(data=request.data)
        if serializer.is_valid():
            try:
                version = openAPIInspector(serializer.data['url'])
            except Exception as e:
                if isinstance(e, JSONDecodeError):
                    raise OpenAPIValidationException('The link provided does not contain a json schema', 'url', status_code=status.HTTP_400_BAD_REQUEST)
                else:
                    raise OpenAPIValidationException('The link provided is not reachable', 'url', status_code=status.HTTP_400_BAD_REQUEST)

            return Response({
                'version': version,
                'satisfied': True if version >= 2 else False
            })
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
