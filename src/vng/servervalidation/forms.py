import logging

from django import forms
from django.core.exceptions import ValidationError
from django.utils.translation import gettext_lazy as _

from ..utils.newman import NewmanManager
from .models import ServerRun

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
        api_endpoint = self.cleaned_data.get('api_endpoint')

        try:
            file = NewmanManager(test_scenario.validation_file, api_endpoint)
            file.prepare_file()
        except Exception as e:  # Gotta catch 'em all
            logger.exception(e)
            self.add_error('test_scenario',
                           ValidationError(_('No valid (Postman) JSON input provided in test scenario.')))
        return self.cleaned_data
