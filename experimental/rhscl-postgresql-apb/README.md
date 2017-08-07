rhscl-postgresql-apb
======================

An apb for deploying [PostgreSQL](https://www.postgresql.org).

## What it does
* Deploys 1 postgresql container.

## Requirements
* ```launch_apb_on_bind: true``` must be set for the broker if you want to create multiple users for each bind.
* NOTE: because of the lack of async bind, this APB could cause failures during bind that the service catalog can not recover from.

## Parameters
* postgresql_database, default 'admin', Postgresql database name.
* postgresql_password, Optional, default is a randomly generated string, Postgresql databaase password.
* postgresql_single_user, Will determine if the APB will create new users for each bind or a single user.
* postgresql_version, Postgresql version. 9.4 and 9.5 are supported.

## Running the application
`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" ansibleplaybookbundle/rhscl-postgresql-apb provision`

## Tearing down the application
`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" ansibleplaybookbundle/rhscl-postgresql-apb deprovision`
