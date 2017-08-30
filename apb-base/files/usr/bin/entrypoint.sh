#!/bin/bash

set -x

# Work-Around
# The OpenShift's s2i (source to image) requires that no ENTRYPOINT exist
# for any of the s2i builder base images.  Our 's2i-apb' builder uses the
# apb-base as it's base image.  But since the apb-base defines its own
# entrypoint.sh, it is not compatible with the current source-to-image.
#
# The below work-around checks if the entrypoint was called within the
# s2i-apb's 'assemble' script process. If so, it skips the rest of the steps
# which are APB run-time specific.
#
# Details of the issue in the link below:
# https://github.com/openshift/source-to-image/issues/475
#
if [[ $@ == *"s2i/assemble"* ]]; then
  echo "---> Performing S2I build... Skipping server startup"
  exec "$@"
  exit $?
fi

ACTION=$1
shift
playbooks=/opt/apb/actions
CREDS="/var/tmp/bind-creds"
TEST_RESULT="/var/tmp/test-result"

if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${USER_NAME:-apb}:x:$(id -u):0:${USER_NAME:-apb} user:${HOME}:/sbin/nologin" >> /etc/passwd
  fi
fi
oc-login.sh

if [[ -e "$playbooks/$ACTION.yaml" ]]; then
  ANSIBLE_ROLES_PATH=/etc/ansible/roles:/opt/ansible/roles ansible-playbook $playbooks/$ACTION.yaml "$@"
elif [[ -e "$playbooks/$ACTION.yml" ]]; then
  ANSIBLE_ROLES_PATH=/etc/ansible/roles:/opt/ansible/roles ansible-playbook $playbooks/$ACTION.yml "$@"
else
  echo "'$ACTION' NOT IMPLEMENTED" # TODO
  exit 0
fi

EXIT_CODE=$?

if [ -f $TEST_RESULT ]; then
   test-retrieval-init
fi
# If we are provisioning an APB, but it's not bindable then the bind-creds
# will never be created. Therefore, if bind-creds exists, we are running
# either provision or bind and the APB is bindable.
#
# bind-init keeps the container running until the broker gathers the bind
# credentials by exec'ing into the container.
if [ -f $CREDS ]; then
   bind-init
fi

exit $EXIT_CODE
