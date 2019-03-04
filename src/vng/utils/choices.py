from djchoices import DjangoChoices, ChoiceItem


class AuthenticationChoices(DjangoChoices):
    jwt = ChoiceItem("JWT")
    header = ChoiceItem("Authorization header")
    no_auth = ChoiceItem("No Authorization")


class StatusChoices(DjangoChoices):
    starting = ChoiceItem("starting")
    running = ChoiceItem("running")
    shutting_down = ChoiceItem("shutting down")
    stopped = ChoiceItem("stopped")
    error_deploy = ChoiceItem("Error deployment")


class ResultChoices(DjangoChoices):
    success = ChoiceItem("Success")
    failed = ChoiceItem("Failed")


class HTTPCallChoiches(DjangoChoices):
    success = ChoiceItem("Succesvol")
    failed = ChoiceItem("Niet succesvol")
    not_called = ChoiceItem("Niet uitgevoerd")


class HTTPMethodChoiches(DjangoChoices):
    POST = ChoiceItem("POST")
    GET = ChoiceItem("GET")
    PUT = ChoiceItem("PUT")
    DELETE = ChoiceItem("DELETE")


class HTTPResponseStatus(DjangoChoices):
    OK_200 = ChoiceItem("200 OK")
    CREATED_201 = ChoiceItem("201 Created")
    MOVED_301 = ChoiceItem("301 Moved Permanently")
    FOUND_302 = ChoiceItem("302 Found")
    BAD_REQUEST_400 = ChoiceItem("400 Bad Request")
    UNAUTHORIZED_401 = ChoiceItem("401 Unauthorized")
    FORBITTEN_403 = ChoiceItem("403 Forbidden")
    NOT_FOUND_404 = ChoiceItem("404 Not Found")
    METHOD_NOT_ALLOWED = ChoiceItem("405 Method Not Allowed")
    INTERNAL_ERROR_500 = ChoiceItem("500 Internal Server Error")
