#!/bin/bash
if [[ -z "${OPENSHIFT_TARGET}" ]] || [[ -z "${OPENSHIFT_USER}" ]] || [[ -z "${OPENSHIFT_PASS}" ]]; then
  echo "Openshift cluster credentials not provided. Assuming the broker is running inside an Openshift cluster"
  echo "Attempting to login with a service account..."
  oc login https://kubernetes.default \
    --certificate-authority /var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
    --token $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
else
  echo "Got OPENSHIFT credentials."
  oc login $OPENSHIFT_TARGET --insecure-skip-tls-verify=true -u $OPENSHIFT_USER -p $OPENSHIFT_PASS
fi
