import functools
from collections.abc import Iterable

from weasyprint import HTML

from django import http
from django.http import Http404, HttpResponse
from django.template import loader, TemplateDoesNotExist
from django.shortcuts import get_object_or_404
from django.views.defaults import ERROR_500_TEMPLATE_NAME
from django.utils.decorators import method_decorator
from django.utils.translation import ugettext_lazy as _
from django.views.decorators.csrf import csrf_exempt, requires_csrf_token
from django.core.exceptions import PermissionDenied
from django.views.generic.edit import ModelFormMixin, ProcessFormView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic.list import MultipleObjectMixin, MultipleObjectTemplateResponseMixin, ListView
from django.views.generic.detail import DetailView


def rsetattr(obj, attr, val):
    pre, _, post = attr.rpartition('.')
    return setattr(rgetattr(obj, pre) if pre else obj, post, val)


def rgetattr(obj, attr, *args):
    def _getattr(obj, attr):
        return getattr(obj, attr, *args)
    return functools.reduce(_getattr, [obj] + attr.split('.'))


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


class ObjectOwner(LoginRequiredMixin):
    field_name = None
    user_field = 'user'

    def check_object(self, obj):
        if self.field_name is None:
            return self.request.user == rgetattr(obj, self.user_field)
        return self.request.user == rgetattr(obj, self.field_name)

    def check_ownership(self, queryset):
        if not isinstance(queryset, Iterable):
            return self.check_object(queryset)
        if len(queryset) == 0:
            return queryset
        if self.field_name is None:
            params = {
                self.user_field: self.request.user
            }
        else:
            params = {
                self.field_name: self.request.user
            }
        qs = queryset.filter(**params).distinct()
        if len(qs) == 0:
            raise PermissionDenied
        else:
            return qs


class CSRFExemptMixin(object):
    @method_decorator(csrf_exempt)
    def dispatch(self, *args, **kwargs):
        return super(CSRFExemptMixin, self).dispatch(*args, **kwargs)


class OwnerSingleObject(ObjectOwner, DetailView):
    pk_name = 'pk'

    def get_queryset(self, object):
        return object.__class__.objects.filter(pk=object.pk)

    def get(self, request, *args, **kwargs):
        self.object = self.get_object()
        self.check_ownership(self.get_queryset(self.object))
        context = self.get_context_data(object=self.object)
        return self.render_to_response(context)

    def get_object(self):
        if not hasattr(self, 'pk_name'):
            raise Exception('Field "pk_name" in subclasses has not been defined')

        pk = self.kwargs.get(self.pk_name)
        if not pk:
            raise Exception('Primary key param name not defined in the URLs')
        obj = get_object_or_404(self.model, pk=pk)

        return obj


class OwnerMultipleObjects(ObjectOwner, ListView):

    def get(self, request, *args, **kwargs):
        self.object_list = self.get_queryset()
        self.check_ownership(self.object_list)
        allow_empty = self.get_allow_empty()

        if not allow_empty:
            if self.get_paginate_by(self.object_list) is not None and hasattr(self.object_list, 'exists'):
                is_empty = not self.object_list.exists()
            else:
                is_empty = not self.object_list
            if is_empty:
                raise Http404(_("Empty list and '%(class_name)s.allow_empty' is False.") % {
                    'class_name': self.__class__.__name__,
                })
        context = self.get_context_data()
        return self.render_to_response(context)


class PDFGenerator():

    def get(self, request, *args, **kwargs):
        response = super().get(request, *args, **kwargs).render().content.decode('utf-8')
        pdf = HTML(string=response, base_url=request.build_absolute_uri('/')).write_pdf()
        response = HttpResponse(pdf, content_type='application/pdf')
        if hasattr(self, 'filename'):
            response['Content-Disposition'] = 'attachment; filename="{}"'.format(self.filename)
        return response
