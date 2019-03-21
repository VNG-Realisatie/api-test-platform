from json.decoder import JSONDecodeError

from django.views.generic import FormView
from django.urls import reverse_lazy

from .forms import OpenApiInspectionForm
from .utils import openAPIInspector


class OpenApiInspection(FormView):

    template_name = 'openApiInspector/openapi-inspection.html'
    form_class = OpenApiInspectionForm
    success_url = reverse_lazy('open_api_inspector:openapi-inspection_result')

    def form_valid(self, form):
        if form.is_valid():
            url = form.cleaned_data['url']
            try:
                version = openAPIInspector(url)
            except Exception as e:
                if isinstance(e, JSONDecodeError) or isinstance(e, AttributeError):
                    form.add_error('url', u'The link provided does not contain a json schema')
                else:
                    form.add_error('url', u'The link provided is not reachable')
                return self.form_invalid(form)
            self.request.session['openapi'] = True if version >= 2 else False
            self.request.session['openapiv'] = version
            return super().form_valid(form)
        return super().form_invalid(form)
