rhscl-postgresql-apb
======================

An APB for deploying [PostgreSQL](https://www.postgresql.org).

## What it does
* Deploys 1 PostgreSQL container.
* Allows the user to select how the APB should manage the APB. you can select to generate a new user and use that user for all bindings, or you can generate new users for each binding.
* If you have selected multiple users for bindings, then on unbind then the user will be deleted from the database.
* This is achieved by launching the APB on bind and unbind.

## Requirements
* ```launch_apb_on_bind: true``` must be set for the broker if you want to create multiple users for each bind.
* NOTE: Because of the lack of async bind, this APB could cause failures during bind that the service catalog can not recover from.
* NOTE: That to use this APB you must build it and deploy it to your own org. 

## Parameters
* postgresql_database, default 'admin', Postgresql database name.
* postgresql_password, Optional, the default is a randomly generated string, Postgresql database password.
* postgresql_single_user, Will determine if the APB will create new users for each bind or use a single generated user.
* postgresql_version, Postgresql version. 9.4 and 9.5 are supported.

## Running the application
`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_TOKEN=<token>" shurley/bind-postgresql-apb provision`

## Tearing down the application
`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_TOKEN=<token>" shurley/bind-postgresql-apb deprovision`
