#!/bin/bash
ACTION=$1
shift
playbooks=/opt/apb/actions

oc-login.sh

if [[ -e "$playbooks/$ACTION.yaml" ]]; then
  ansible-playbook $playbooks/$ACTION.yaml $@
elif [[ -e "$playbooks/$ACTION.yml" ]]; then
  ansible-playbook $playbooks/$ACTION.yml $@
else
  echo "'$ACTION' NOT IMPLEMENTED" # TODO
fi
