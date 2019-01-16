import logging

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

        try:
            pass
            # file = NewmanManager(test_scenario.validation_file, api_endpoint)
            # file.prepare_file()
        except Exception as e:  # Gotta catch 'em all
            logger.exception(e)
            self.add_error('test_scenario',
                           ValidationError(_('No valid (Postman) JSON input provided in test scenario.')))
        return self.cleaned_data


class CreateEndpointForm(forms.ModelForm):

    class Meta:
        model = Endpoint
        fields = ['url']

    def __init__(self, quantity=0, field_name='field', *args, **kwargs):
        super().__init__(*args, **kwargs)
        for i in range(quantity):
            self.fields['{}-{}'.format(field_name, i + 1)] = forms.URLField()
