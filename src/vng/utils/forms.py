
from django import forms
from registration.forms import RegistrationForm
from registration.users import UserModel, UsernameField

from captcha.fields import ReCaptchaField
from captcha.widgets import ReCaptchaV2Checkbox

User = UserModel()


class RegistrationCaptcha(RegistrationForm):
    captcha = ReCaptchaField(widget=ReCaptchaV2Checkbox)

    class Meta:
        model = User
        fields = (UsernameField(), "email",)


class CustomModelChoiceField(forms.ModelChoiceField):

    def label_from_instance(self, obj):
        """
        Convert objects into strings and generate the labels for the choices
        presented by this object. Subclasses can override this method to
        customize the display of the choices.
        """
        return obj
