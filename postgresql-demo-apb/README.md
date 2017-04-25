postgresql-demo-apb
======================

An apb for deploying [PostgreSQL](https://www.postgresql.org).  

## What it does
* Deploys 1 postgresql.

## Requirements

## Parameters
* NAMESPACE: Optional, default 'postgresql-demo-apb', Namespace to deploy the cluster in.
* POSTGRESQL_DATABASE, default 'admin', Postgresql database name.
* POSTGRESQL_PASSWORD, default 'admin', Postgresql database password.
* POSTGRESQL_USER, default 'admin', Postgresql database username.
* OPENSHIFT_TARTET: Required, target openshift deployment
* OPENSHIFT_USER: Required, openshift user to login as
* OPENSHIFT_PASS: Required, openshift users password

## Running the application
`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" ansibleplaybookbundle/postgresql-demo-apb provision`

## Tearing down the application
`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" ansibleplaybookbundle/postgresql-demo-apb deprovision`
