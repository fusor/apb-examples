#!/bin/bash
ACTION=$1
USER_ID=$(id -u)
shift
playbooks=/opt/apb/actions

set -x

if [ ${USER_UID} != ${USER_ID} ]; then
  sed "s@${USER_NAME}:x:\${USER_ID}:@${USER_NAME}:x:${USER_ID}:@g" ${BASE_DIR}/etc/passwd.template > /etc/passwd
fi
oc-login.sh

touch /etc/apb/bind-creds
if [[ -e "$playbooks/$ACTION.yaml" || -e "$playbooks/$ACTION.yml" ]]; then
  ansible-playbook $playbooks/$ACTION.yml "$@" || ansible-playbook $playbooks/$ACTION.yaml "$@"

  # bind-init keeps the container running until the broker gathers the bind
  # credentials by exec'ing into the container.
  if [[ "${ACTION}" == "bind" || "${ACTION}" == "provision" ]]; then
      bind-init
  fi
else
  echo "'$ACTION' NOT IMPLEMENTED" # TODO
fi
