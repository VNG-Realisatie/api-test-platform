from cms.plugin_base import CMSPluginBase   
from cms.plugin_pool import plugin_pool
from cms.models.pluginmodel import CMSPlugin 
from django.utils.translation import ugettext_lazy as _


@plugin_pool.register_plugin
class HelloPlugin(CMSPluginBase):
    model = CMSPlugin
    render_template = "hello_plugin.html"
    cache = False
    name = 'hello_plugin'

    def render(self, context, instance, placeholder):
        context = super().render(context, instance, placeholder)
        context['wave'] = " hello"
        return context

@plugin_pool.register_plugin
class TextPlugin(CMSPluginBase):
    model = CMSPlugin
    render_template = "hello_plugin.html"
    cache = False
    name = 'hello_plugin'

    def render(self, context, instance, placeholder):
        context = super().render(context, instance, placeholder)
        context['wave'] = " hello"
        return context


