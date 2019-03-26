from django import forms
from django.utils.translation import ugettext_lazy as _

from .models import SessionType
from ..utils.choices import AuthenticationChoices


class SessionTypeForm(forms.ModelForm):

    class Meta:
        model = SessionType
        fields = '__all__'

    def clean_featured(self):
        return forms.ValidationError('asds')

    def clean(self):
        cleaned_data = super().clean()
        if cleaned_data['authentication'] == AuthenticationChoices.jwt:
            if not cleaned_data['client_id'] or not cleaned_data['secret']:
                raise forms.ValidationError(_('Client_id and secret must be provided with this authentication method'))
        elif cleaned_data['authentication'] == AuthenticationChoices.header:
            if not cleaned_data['header']:
                raise forms.ValidationError(_('Header must be provided with this authentication method'))
        import pdb
        pdb.set_trace()
