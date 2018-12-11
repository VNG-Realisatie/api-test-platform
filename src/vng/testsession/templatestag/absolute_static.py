from django import template


register = template.Library()


@register.tag
def abs_url():
    return 'tests'
