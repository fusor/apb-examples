nginx-php-fpm-apb
======================

An apb for deploying nginx and php-fpm containers.

## What it does
* Deploys 1 nginx container and 1 php-fpm container and links them.

## Requirements
* N/A

## Parameters
* N/A

## Running the application
`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" ansibleplaybookbundle/nginx-php-fpm-apb provision`

## Tearing down the application
`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" ansibleplaybookbundle/nginx-php-fpm-apb deprovision`
