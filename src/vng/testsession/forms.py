from django import forms
from django.utils.translation import ugettext_lazy as _

from .models import SessionType, Session
from ..utils.choices import AuthenticationChoices


class CustomModelChoiceField(forms.ModelChoiceField):

    def label_from_instance(self, obj):
        """
        Convert objects into strings and generate the labels for the choices
        presented by this object. Subclasses can override this method to
        customize the display of the choices.
        """
        return str(obj)


class SessionTypeFormAdmin(forms.ModelForm):

    class Meta:
        model = SessionType
        fields = '__all__'

    def clean(self):
        cleaned_data = super().clean()
        if cleaned_data['authentication'] == AuthenticationChoices.jwt:
            if not cleaned_data['client_id'] or not cleaned_data['secret']:
                raise forms.ValidationError(_('Client_id and secret must be provided with this authentication method'))
        elif cleaned_data['authentication'] == AuthenticationChoices.header:
            if not cleaned_data['header']:
                raise forms.ValidationError(_('Header must be provided with this authentication method'))
        return cleaned_data


class SessionForm(forms.ModelForm):

    session_type = CustomModelChoiceField(SessionType.objects.all(), widget=forms.RadioSelect, empty_label=None)

    class Meta:
        model = Session
        fields = ['session_type', 'sandbox']
