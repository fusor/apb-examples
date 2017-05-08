foreman-apb
======================

An apb for deploying [Foreman](http://theforeman.org/).  

## What it does
* Deploys a Foreman installation to the (optionally) specified namespace. The installation consists of 1 postgresql and 1 foreman container.

## Requirements

## Parameters
* CERTIFICATE_CN, default 'foreman', Common Name for SSL Certificate
* CREATE_PVS, default false, Create hostPath PV's. Default expects pre-created PV's.
* DEPLOY_POSTGRESQL, default true, Deploy a dedicated postgresql instance
* DB_ENCRYPTION_KEY, default is randomly generated, DB Encryption key
* FOREMAN_ADMIN_PASSWORD, default 'changeme', Foreman admin password.
* NAMESPACE: Optional, default 'foreman-apb', Namespace to deploy the cluster in.
* POSTGRESQL_DATABASE, default 'foreman', Postgresql database name.
* POSTGRESQL_HOSTNAME, default 'tfm-postgresql', Postgresql database hosts hostname. Accept default if deploying a dedicated postgresql instance.
* POSTGRESQL_PASSWORD, default 'admin', Postgresql database password.
* POSTGRESQL_USER, default 'admin', Postgresql database username.
* OPENSHIFT_TARGET: Required, target openshift deployment
* OPENSHIFT_USER: Required, openshift user to login as
* OPENSHIFT_PASS: Required, openshift users password
* PV_BASE_PATH: default '/opt/k8s', path for hostPath PV's if created
* USE_CN_FOR_ROUTE_HOSTNAME: Set the route hostname to match the SSL Certificate CN
* VERSION:, default '1.14', Foreman version to deploy. Valid values are '1.13' and '1.14'

## Running the application
Deploy Foreman with a dedicated postgresql instance:

`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" ansibleplaybookbundle/foreman-apb provision`

Deploy Foreman with a dedicated postgresql instance and create hostPath Persistent Volumes:

`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" -e CREATE_PVS=true ansibleplaybookbundle/foreman-apb provision`

Deploy a postgresql-apb (representing any postgresql container/host) and then Foreman to use this already available postgresql instance:

`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" -e POSTGRESQL_DATABASE=foreman -e POSTGRESQL_USER=foreman -e POSTGRESQL_PASSWORD=foreman -e NAMESPACE=foreman ansibleplaybookbundle/postgresql-apb provision`

`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" -e POSTGRESQL_DATABASE=foreman -e POSTGRESQL_USER=foreman -e POSTGRESQL_PASSWORD=foreman -e NAMESPACE=foreman -e DEPLOY_POSTGRESQL=false -e POSTGRESQL_HOSTNAME=postgresql ansibleplaybookbundle/foreman-apb provision`

Deploy foreman and postgresql with a custom CN for SSL cert and route:

`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" -e CERTIFICATE_CN="foreman.example.com" -e USE_CN_FOR_ROUTE_HOSTNAME=true ansibleplaybookbundle/foreman-apb provision`

## Tearing down the application

`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" ansibleplaybookbundle/foreman-apb deprovision`

## Upgrade an instance:

`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" -e NAMESPACE=foreman -e VERSION=1.14 ansibleplaybookbundle/postgresql-apb provision`
