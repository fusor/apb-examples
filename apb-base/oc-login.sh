#!/bin/bash
if [[ ! -z "${OPENSHIFT_TARGET}" ]] && [[ ! -z "${OPENSHIFT_TOKEN}" ]]; then
  echo "Got OPENSHIFT token."
  LOGIN_PARAMS="--insecure-skip-tls-verify=true --token=$OPENSHIFT_TOKEN"
else if [[ -z "${OPENSHIFT_TARGET}" ]] || [[ -z "${OPENSHIFT_USER}" ]] || [[ -z "${OPENSHIFT_PASS}" ]]; then
  echo "Openshift cluster credentials not provided. Assuming the broker is running inside an Openshift cluster"
  echo "Attempting to login with a service account..."
  OPENSHIFT_TARGET=https://kubernetes.default
  LOGIN_PARAMS="--certificate-authority /var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
    --token $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)"
else
  echo "Got OPENSHIFT credentials."
  LOGIN_PARAMS="--insecure-skip-tls-verify=true -u $OPENSHIFT_USER -p $OPENSHIFT_PASS"
fi
fi

oc login $OPENSHIFT_TARGET $LOGIN_PARAMS
