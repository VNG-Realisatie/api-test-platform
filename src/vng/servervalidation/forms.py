import logging
import copy
import collections

from django import forms
from django.core.exceptions import ValidationError
from django.utils.translation import gettext_lazy as _

from .models import ServerRun, Endpoint, TestScenario
from ..utils.newman import NewmanManager
from ..utils.forms import CustomModelChoiceField

logger = logging.getLogger(__name__)


class CreateServerRunForm(forms.ModelForm):

    test_scenario = CustomModelChoiceField(TestScenario.objects.all(), widget=forms.RadioSelect, empty_label=None)

    class Meta:
        model = ServerRun
        fields = ['test_scenario', 'scheduled']

    def clean(self):
        """
        Tries to process the test scenario json to make sure the input is valid.
        """
        test_scenario = self.cleaned_data.get('test_scenario')


class CreateEndpointForm(forms.ModelForm):

    class Meta:
        model = Endpoint
        fields = ['url']
        labels = {
            'url': 'url'
        }

    def set_labels(self, labels):
        tmp = collections.OrderedDict()
        for k, new in zip(self.fields.keys(), labels):
            self.fields[k].label = new

    def add_text_area(self, text_area):
        for e in text_area:
            self.fields[e] = forms.CharField(widget=forms.Textarea)

    def __init__(self, quantity=0, field_name='field', text_area=[], text_area_field_name=[], *args, **kwargs):
        super().__init__(*args, **kwargs)
        # Override the field type since in the model is charfield
        self.fields['url'] = forms.URLField()
        for i in range(quantity):
            if isinstance(field_name, str):
                self.fields['{}-{}'.format(field_name, i + 1)] = forms.URLField()
            else:
                self.fields[field_name[i]] = forms.URLField()
        for i, e in enumerate(text_area):
            self.fields[text_area_field_name[i]] = forms.CharField(widget=forms.Textarea)
