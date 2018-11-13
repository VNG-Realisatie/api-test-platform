from django.contrib import admin
import vng.testsession.models as model 

# Register your models here.
admin.site.register(model.Session_type)
admin.site.register(model.Session)