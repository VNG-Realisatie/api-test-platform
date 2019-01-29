from djchoices import DjangoChoices, ChoiceItem


class StatusChoices(DjangoChoices):
    starting = ChoiceItem("starting")
    running = ChoiceItem("running")
    shutting_down = ChoiceItem("shutting down")
    stopped = ChoiceItem("stopped")


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
