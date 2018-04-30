nginx-php-fpm-apb
======================

An apb for deploying nginx and php-fpm containers.

## What it does
* Deploys 1 nginx container and 1 php-fpm container and links them.

## Requirements
* Existing project

## Parameters
* namespace: name of an existing namespace / project

## Running the application
`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_TOKEN"=<openshift_token>" ansibleplaybookbundle/nginx-php-fpm-apb provision --extra-vars "namespace=<your project name/namespace>"`

## Tearing down the application
`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_TOKEN"=<openshift_token>" ansibleplaybookbundle/nginx-php-fpm-apb deprovision --extra-vars "namespace=<your project name/namespace>"`
