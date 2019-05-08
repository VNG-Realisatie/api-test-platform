from django import template

register = template.Library()


@register.filter
def to_int(value):
    return int(value)


@register.filter
def index(l, i):
    return l[int(i)]


@register.filter
def pop(obj, prop):
    if not hasattr(obj, prop):
        return ''
    r = getattr(obj, prop)()
    setattr(obj, prop, '')
    # delattr(obj, prop)
    return r
