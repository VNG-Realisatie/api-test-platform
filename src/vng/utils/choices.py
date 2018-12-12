from djchoices import DjangoChoices, ChoiceItem


class StatusChoices(DjangoChoices):
    starting = ChoiceItem("starting")
    running = ChoiceItem("running")
    stopped = ChoiceItem("stopped")


class HTTPCallChoiches(DjangoChoices):
    success = ChoiceItem("Succesvol")
    failed = ChoiceItem("Niet succesvol")
    not_called = ChoiceItem("Niet uitgevoerd")


class HTTPMethodChoiches(DjangoChoices):
    POST = ChoiceItem("POST")
    GET = ChoiceItem("GET")
    PUT = ChoiceItem("PUT")
    DELETE = ChoiceItem("DELETE")
