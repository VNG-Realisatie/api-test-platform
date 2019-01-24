from collections import Iterable
from rest_framework import permissions


class IsOwnerOrReadOnly(permissions.BasePermission):
    """
    Custom permission to only allow owners of an object to edit it.
    """

    def has_object_permission(self, request, view, obj):
        # Read permissions are allowed to any request,
        # so we'll always allow GET, HEAD or OPTIONS requests.
        if request.method in permissions.SAFE_METHODS:
            return True

        # Write permissions are only allowed to the owner of the snippet.
        return obj.user == request.user


class IsOwner(permissions.BasePermission):
    """
    Custom permission to only allow owners of an object to edit it.
    """

    def has_permission(self, request, view):
        return request.user

    def has_object_permission(self, request, view, obj):
        if not isinstance(obj, Iterable):
            obj = [obj]
        for o in obj:
            if hasattr(view, 'user_path'):
                for path in getattr(view, 'user_path'):
                    o = getattr(o, path)
            if o.user != request.user:
                return False
        return True


class IsThePerson(permissions.BasePermission):
    """
    Custom permission to only allow users to modify/retrive its informations
    """

    def has_permission(self, request, view):
        return request.user

    def has_object_permission(self, request, view, obj):
        return obj == request.user
