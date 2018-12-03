import uuid
import subprocess
import logging
import os
import json
from urllib.parse import urlparse
from django.conf import settings

logger = logging.getLogger(__name__)

class NewmanManager:
    REPORT_FOLDER = settings.MEDIA_ROOT+'/newman'
    RUN_COMMAND = 'newman run --reporters html {} --reporter-html-export '+REPORT_FOLDER+'/{}.html'    #'newman run --reporters html {}'
    TOKEN = 'TOKEN'

    def __init__(self, file, api_endpoint):
        self.file = file
        self.file_to_be_discarted = []
        self.api_endpoint = api_endpoint

    def __del__(self):
        for file in self.file_to_be_discarted:
            full_path = os.path.realpath(file.name)
            os.remove(full_path)


    def run_command(self, command, *args):
        command = command.format(*args)
        logger.debug('running the COMMAND: {}'.format(command))
        subp = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        err = subp.stderr.read()
        logger.debug(str(err))
        return (subp.stdout, err)


    def prepare_file(self):
        filename = str(uuid.uuid4())
        logger.debug('Preparing untokenizeing the file {} with the base {}, output file: {}'.format(self.file.path, self.api_endpoint, filename))
        with open(self.file.path) as f:
            input = json.load(f)
        f.close()

        base_dir = os.path.dirname(self.file.path)
        output_path = '{}/{}'.format(base_dir, filename)

        for item in input['item']:
            item['request']['url']['host'] = urlparse(self.api_endpoint).hostname.split('.')


        output = open(output_path, 'w')
        print(input)
        json.dump(input, output)
        output.close()
        self.file_path = output_path
        self.file_to_be_discarted.append(output)



    def execute_test(self):
        if self.api_endpoint is not None:
            self.prepare_file()
        filename = str(uuid.uuid4())
        output, error = self.run_command(self.RUN_COMMAND, self.file_path, filename)
        f = open('{}/{}.html'.format(self.REPORT_FOLDER, filename))
        self.file_to_be_discarted.append(f)

        if error is not None:
            return f


