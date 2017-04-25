manageiq-apb
======================

An AnsibleApp for deploying [ManageIQ](http://manageiq.org/).

## What it does
* Deploys a ManageIQ installation to the (optionally) specified namespace. The installation consists of 1 postgresql, 1 memcached, and one application pod.

## Requirements
* The deployment will need to run by a user with sufficient privileges to run `oadm policy add-scc-to-user privileged system:serviceaccount:{{ namespace }}:default` otherwise the deployment will fail.

## Parameters
* APPLICATION_INIT_DELAY, default 60, Time to delay web app startup.
* DATABASE_REGION, default 1, MIQ Instance Region.
* DATABASE_SERVICE_NAME, default 'manageiq-postgresql', Name of the database pod/server.
* MEMCACHED_MAX_CONNECTIONS, default 1024, Maximum number of connections memcached will accept
* MEMCACHED_MAX_MEMORY, default 64, Maximum memory memcached will use in MB.
* MEMCACHED_SLAB_PAGE_SIZE, default '1M', Memcached slab size.
* MEMCACHED_SERVICE_NAME, default 'manageiq-memcached', Name of the memcached pod/server.
* NAMESPACE: Optional, default 'manageiq-apb', Namespace to deploy the cluster in.
* POSTGRESQL_DATABASE, default 'vmdb_production', Postgresql database name.
* POSTGRESQL_PASSWORD, default 'admin', Postgresql database password.
* POSTGRESQL_USER, default 'admin', Postgresql database username.
* OPENSHIFT_TARTET: Required, target openshift deployment
* OPENSHIFT_USER: Required, openshift user to login as
* OPENSHIFT_PASS: Required, openshift users password

## Running the application
`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" ansibleplaybookbundle/manageiq-apb provision`
