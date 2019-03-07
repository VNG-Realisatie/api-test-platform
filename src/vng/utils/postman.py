import json
from .choices import ResultChoices


def get_outcome_json(_json):
    error_codes = range(400, 600)

    json_obj = json.loads(_json)
    if json_obj['run']['failures'] != []:
        return ResultChoices.failed
    for call in json_obj['run']['executions']:
        if str(call['response']['code']) in error_codes:
            return ResultChoices.failed
    return ResultChoices.success
