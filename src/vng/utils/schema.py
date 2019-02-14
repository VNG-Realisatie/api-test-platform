from drf_yasg import openapi
from drf_yasg.views import get_schema_view
from drf_yasg.inspectors import SwaggerAutoSchema
from rest_framework import permissions

schema_view = get_schema_view(
    openapi.Info(
        title="API Testvoorziening",
        default_version='v1',
        description="API test platform",
    ),
    public=True,
    permission_classes=(permissions.AllowAny,),
)


class CompoundTagsSchema(SwaggerAutoSchema):

    mapping = {
        'result': 'actions',
        'stop': 'actions'
    }

    def get_tags(self, operation_keys):
        '''
        Function that enwraps each entity's api methods in the same bunch
        E.g.
            session
                POST session
                GET session
        '''
        if 'auth' in operation_keys:
            return super().get_tags(operation_keys)
        if 'v1' in operation_keys:
            i = operation_keys.index('v1')
            del operation_keys[i]
        if '' in operation_keys:
            i = operation_keys.index('')
            del operation_keys[i]
        for k, v in self.mapping.items():
            if k in operation_keys:
                i = operation_keys.index(k)
                operation_keys[i] = v
        return [' > '.join(operation_keys[:-1])]
