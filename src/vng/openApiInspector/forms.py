from django import forms


class OpenApiInspectionForm(forms.Form):

    url = forms.URLField()
