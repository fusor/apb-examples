#!/usr/bin/env bash

CERTS=certs
ORG=theforeman
TMP="$(mktemp -d)"

mkdir -p certs
# create CA key
openssl genrsa -out certs/ca.key 4096 #&> /dev/null

# create signing request
openssl req \
  -new \
  -key certs/ca.key \
  -out ${TMP}/ca.req \
  -subj "/CN=foremanca/O=$ORG" #&> /dev/null

# create a self-signed CA certificate
openssl x509 \
  -req \
  -days 7035 \
  -sha256 \
  -extensions ca  \
  -signkey certs/ca.key \
  -in ${TMP}/ca.req \
  -out certs/ca.crt #&> /dev/null

# create key
openssl genrsa -out certs/httpd.key 4096 #&> /dev/null

# create signing request
openssl req \
  -new \
  -key certs/httpd.key \
  -out ${TMP}/httpd.req \
  -subj "/CN=$CERTIFICATE_CN/O=$ORG" #&> /dev/null

# create a signed certificate
openssl x509 \
  -req \
  -CA certs/ca.crt \
  -CAkey certs/ca.key \
  -CAcreateserial \
  -in ${TMP}/httpd.req \
  -out certs/httpd.crt #&> /dev/null

# clean
rm ${TMP}/*.req
rmdir ${TMP}
