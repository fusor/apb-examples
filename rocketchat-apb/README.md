rocketchat-apb
======================

An apb for deploying [RocketChat](https://rocket.chat).

## What it does
* Deploys 1 rocketchat container and 1 mongo container.

## Requirements
* N/A

## Parameters
* mongodb_user, Required, default 'rocketchat', MongoDB username.
* mongodb_pass, Required, default is a randomly generated string, MongoDB password.
* mongodb_name, Required, default 'rocketchat', MongoDB database name to be created.
* mongodb_version, Required, default '3.2', MongoDB version. 3.2, 3.4, and 3.5 are supported.
* mongodb_admin_pass, Required, default 'changeme', MongoDB administrator password.
## Running the application
`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" ansibleplaybookbundle/rocketchat-apb provision`

## Tearing down the application
`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" ansibleplaybookbundle/rocketchat-apb deprovision`
