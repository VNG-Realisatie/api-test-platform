from django.urls import reverse_lazy
from django.views.generic.edit import UpdateView
from django.contrib.auth.mixins import LoginRequiredMixin

from .models import User


class UserUpdateView(LoginRequiredMixin, UpdateView):

    template_name = 'user_profile/update.html'
    model = User
    fields = ['first_name', 'last_name', 'email']

    def get_object(self, queryset=None):
        return self.request.user

    def get_success_url(self):
        return '{}?result={}'.format(reverse_lazy('user_edit:edit_profile',), True)
