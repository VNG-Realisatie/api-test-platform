import logging
import collections

from django import forms
from django.core.exceptions import ValidationError
from django.utils.translation import gettext_lazy as _

from ..utils.newman import NewmanManager
from .models import ServerRun, Endpoint

logger = logging.getLogger(__name__)


class CreateServerRunForm(forms.ModelForm):
    class Meta:
        model = ServerRun
        fields = ['test_scenario']

    def clean(self):
        """
        Tries to process the test scenario json to make sure the input is valid.
        """
        test_scenario = self.cleaned_data.get('test_scenario')


class CreateEndpointForm(forms.ModelForm):
    field_order = ['url']

    class Meta:
        model = Endpoint
        fields = ['url']
        labels = {
            'url': 'url'
        }

    def set_labels(self, labels):
        tmp = dict(self.fields)
        for k, new in zip(self.fields.keys(), labels):
            tmp[k].label = new
        self.fields = collections.OrderedDict(tmp)

    def __init__(self, quantity=0, field_name='field', text_area=[], *args, **kwargs):
        super().__init__(*args, **kwargs)
        for i in range(quantity):
            if isinstance(field_name, str):
                field_name.append(field_name)
                self.fields['{}-{}'.format(field_name, i + 1)] = forms.URLField()
            else:
                field_name.append(field_name[i])
                self.fields[field_name[i]] = forms.URLField()
        for e in text_area:
            field_name.append(e)
            self.fields[e] = forms.CharField(widget=forms.Textarea)
