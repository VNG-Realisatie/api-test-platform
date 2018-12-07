from djchoices import DjangoChoices, ChoiceItem


class StatusChoices(DjangoChoices):
    starting = ChoiceItem("starting")
    running = ChoiceItem("running")
    stopped = ChoiceItem("stopped")
