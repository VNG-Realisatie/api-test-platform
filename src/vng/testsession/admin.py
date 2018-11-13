from django.contrib import admin
import vng.testsession.models as model 

# Register your models here.
admin.site.register(model.SessionType)
admin.site.register(model.Session)