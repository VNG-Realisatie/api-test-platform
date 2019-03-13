
from registration.forms import RegistrationForm
from registration.users import UserModel, UsernameField

from captcha.fields import ReCaptchaField
from captcha.widgets import ReCaptchaV2Invisible

User = UserModel()


class RegistrationCaptcha(RegistrationForm):
    # captcha = ReCaptchaField(widget=ReCaptchaV2Invisible)

    class Meta:
        model = User
        fields = (UsernameField(), "email",)
