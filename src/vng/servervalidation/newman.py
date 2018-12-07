import uuid
import subprocess
import logging
import os
import json
from urllib.parse import urlparse
from django.conf import settings
from django.http import HttpResponse

from ..utils.commands import run_command

logger = logging.getLogger(__name__)


class NewmanManager:
    REPORT_FOLDER = settings.MEDIA_ROOT + '/newman'
    RUN_COMMAND = 'newman run --reporters html {} --reporter-html-export ' + REPORT_FOLDER + '/{}.html'
    TOKEN = 'TOKEN'

    def __init__(self, file, api_endpoint):
        self.file = file
        self.file_to_be_discarted = []

        self.api_endpoint = api_endpoint
        if not os.path.exists(self.REPORT_FOLDER):
            os.makedirs(self.REPORT_FOLDER)

    def __del__(self):
        for file in self.file_to_be_discarted:
            full_path = os.path.realpath(file.name)
            logger.debug('Deleteing file {}'.format(full_path))
            os.remove(full_path)

    def run_command(self, command, *args):
        command = command.format(*args)
        return run_command(command)

    def prepare_file(self):
        '''
        Substitute the url of the file with the api_endpoint provided
        '''
        filename = str(uuid.uuid4())
        logger.debug('Preparing untokenizeing the file {} with the base {}, output file: {}'.format(self.file.path, self.api_endpoint, filename))
        with open(self.file.path) as f:
            input = json.load(f)
        f.close()

        base_dir = os.path.dirname(self.file.path)
        output_path = '{}/{}'.format(base_dir, filename)

        for item in input['item']:
            item['request']['url']['host'] = urlparse(self.api_endpoint).hostname.split('.')
        with open(output_path, 'w') as output:
            json.dump(input, output)
            output.close()
            self.file_path = output_path
            self.file_to_be_discarted.append(output)

    def execute_test(self):
        if self.api_endpoint is not None:
            self.prepare_file()
        else:
            self.file_path = self.file.path
        filename = str(uuid.uuid4())
        output, error = self.run_command(self.RUN_COMMAND, self.file_path, filename)
        if error:
            return HttpResponse(status=500)
        with open('{}/{}.html'.format(self.REPORT_FOLDER, filename)) as f:
            self.file_to_be_discarted.append(f)

            if error is not None:
                return f
