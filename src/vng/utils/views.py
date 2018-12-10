from django import http
from django.http import Http404, HttpResponse, HttpResponseRedirect
from django.template import loader, TemplateDoesNotExist
from django.shortcuts import get_object_or_404
from django.views.defaults import ERROR_500_TEMPLATE_NAME
from django.views.decorators.csrf import requires_csrf_token
from django.views.generic.edit import ModelFormMixin, ProcessFormView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic.list import MultipleObjectMixin, MultipleObjectTemplateResponseMixin


@requires_csrf_token
def server_error(request, template_name=ERROR_500_TEMPLATE_NAME):
    """
    500 error handler.

    Templates: :template:`500.html`
    Context: None
    """
    try:
        template = loader.get_template(template_name)
    except TemplateDoesNotExist:
        if template_name != ERROR_500_TEMPLATE_NAME:
            # Reraise if it's a missing custom template.
            raise
        return http.HttpResponseServerError('<h1>Server Error (500)</h1>', content_type='text/html')
    context = {'request': request}
    return http.HttpResponseServerError(template.render(context))


class ListAppendView(MultipleObjectMixin, MultipleObjectTemplateResponseMixin, ModelFormMixin, ProcessFormView):
    """
    A View that displays a list of objects and a form to create a new object.
    The View processes this form.
    """
    template_name_suffix = '_append'
    allow_empty = True

    def get(self, request, *args, **kwargs):
        self.object_list = self.get_queryset()
        allow_empty = self.get_allow_empty()
        if not allow_empty and len(self.object_list) == 0:
            raise Http404(_(u"Empty list and '%(class_name)s.allow_empty' is False.")
                          % {'class_name': self.__class__.__name__})
        self.object = None
        form_class = self.get_form_class()
        form = self.get_form(form_class)
        context = self.get_context_data(object_list=self.object_list, form=form)
        return self.render_to_response(context)

    def post(self, request, *args, **kwargs):
        self.object = None
        return super(ListAppendView, self).post(request, *args, **kwargs)

    def form_invalid(self, form):
        self.object_list = self.get_queryset()
        return self.render_to_response(self.get_context_data(object_list=self.object_list, form=form))


class OwnerObjectMixin(LoginRequiredMixin):
    def get_object(self):
        pk = self.kwargs.get(self.pk_name)
        if pk is None:
            raise Exception('Primary key param name not defined')
        obj = get_object_or_404(self.model, pk=pk)
        if obj.user != self.request.user:
            return HttpResponse('Unauthorized', status=401)
        else:
            return obj
