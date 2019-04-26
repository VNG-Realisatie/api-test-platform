from django import template

register = template.Library()


@register.filter
def index(objs, i):
    return objs[int(i)]
