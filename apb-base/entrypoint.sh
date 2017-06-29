#!/bin/bash
ACTION=$1
USER_ID=$(id -u)
shift
playbooks=/opt/apb/actions
CREDS="/etc/apb/bind-creds"

set -x

if [ ${USER_UID} != ${USER_ID} ]; then
  sed "s@${USER_NAME}:x:\${USER_ID}:@${USER_NAME}:x:${USER_ID}:@g" ${BASE_DIR}/etc/passwd.template > /etc/passwd
fi
oc-login.sh

if [[ -e "$playbooks/$ACTION.yaml" || -e "$playbooks/$ACTION.yml" ]]; then
  ansible-playbook $playbooks/$ACTION.yml "$@" || ansible-playbook $playbooks/$ACTION.yaml "$@"

  # If we are provisioning an APB, but it's not bindable then the bind-creds
  # will never be created. Therefore, if bind-creds exists, we are running
  # either provision or bind and the APB is bindable.
  #
  # bind-init keeps the container running until the broker gathers the bind
  # credentials by exec'ing into the container.
  if [ -f $CREDS ]; then
     bind-init
  fi
else
  echo "'$ACTION' NOT IMPLEMENTED" # TODO
fi
