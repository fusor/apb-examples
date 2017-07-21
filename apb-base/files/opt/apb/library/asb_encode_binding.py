#!/usr/bin/python

ANSIBLE_METADATA = {'metadata_version': '1.0',
                    'status': ['preview'],
                    'supported_by': 'community'}


DOCUMENTATION = '''
---
module: asb_encode_binding
short_description: Encodes binding fields for Ansible Service Broker
description:
     - Takes a dictionary of fields and makes them available to Ansible Service Broker
       to read and create a binding when running the action (provision, bind, etc)
notes: []
requirements: []
author:
    - "Red Hat, Inc."
options:
  fields:
    description:
      - 'dictionary of key/value pairs to encode for a binding.  Keys will become the injected environment variables.'
    required: true
    default: {}
'''

EXAMPLES = '''
- name: encode bind credentials
  asb_encode_binding:
    fields:
      POSTGRESQL_HOST: postgresql
      POSTGRESQL_PORT: 5432
      POSTGRESQL_USER: "{{ postgresql_user }}"
      POSTGRESQL_PASSWORD: "{{ postgresql_password }}"
      POSTGRESQL_DATABASE: "{{ postgresql_database }}"
'''

import json
import base64
from ansible.module_utils.basic import AnsibleModule

ENCODED_BINDING_PATH = "/var/tmp/bind-creds"


def main():

    argument_spec = dict(
        fields=dict(required=True, type='dict')
    )

    ansible_module = AnsibleModule(argument_spec=argument_spec)

    try:
        fields_json = json.dumps(ansible_module.params['fields'])
        encoded_fields = base64.b64encode(fields_json)
    except Exception as error:
        ansible_module.fail_json(msg="Error attempting to encode binding: " + str(error))

    try:
        with open(ENCODED_BINDING_PATH, "w") as binding_file:
            binding_file.write(encoded_fields)
    except Exception as error:
        ansible_module.fail_json(msg="Error attempting to write binding: " + str(error))

    ansible_module.exit_json(changed=True, encoded_fields=encoded_fields)


if __name__ == '__main__':
    main()
