class CommandError(Exception):
    def __init__(self, message, command):
        message += " | " + " ".join(command)
        super().__init__(message)
        self.command = command
