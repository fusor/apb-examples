rhscl-mysql-apb
===============

An Ansible Playbook Bundle (APB) to deploy [MySQL](https://www.mysql.com).

## What it does
* It deploys a MySQL server using the
  [Software Collections (SCL) image for MySQL](https://github.com/sclorg/mysql-container/)

## Requirements
* N/A

## Parameters

* mysql_database: MySQL database name (default: 'devel')
* mysql_password: MySQL database password (default: randomly generated)
* mysql_user: MySQL database username (default: 'devel')
* mysql_version: MySQL version to deploy. 5.6 and 5.7 are available (default: '5.7')
* volume_size: size of the PVC to request if persistent storage is requested (default: '10 Gi')
* service_name: name of the service, used for names and labels of provisioned resources (default: 'mysql')
* namespace: target namespace/project where resources will be provisioned (default: 'rhscl-mysql-apb')

### Environment variables

For convenience, the parameters above can be set/overriden via environment variables on the APB container. The environment variable names are the same in all upper case letters; for example, you can specify the `namespace` parameter via the `NAMESPACE` environment variable.

## Plans

There are 2 plans available:

* Development (*dev*) (default): deploys a single MySQL server with ephemeral storage, i.e. no storage persistence: when the container stops its data is lost.
* Production (*prod*'): deploys a singgle MySQL server with persistent storage. The storage is allocated via a Persistent Volume Claim of `volume_size`.

## Running the application

    docker run -e "OPENSHIFT_TARGET=<openshift_api_url>" \
               -e "OPENSHIFT_TOKEN=<token>" \
               ansibleplaybookbundle/mysql-apb provision

You can pass additional parameters to `ansible-playbook` by adding them at the end; for example, you can request more verbose output with one or more `-v` and pass additional variables with `--extra-vars`.

For example, this will request a *prod* plan and specify a custom database name and volume size:

    docker run -e "OPENSHIFT_TARGET=<openshift_api_url>" \
               -e "OPENSHIFT_TOKEN=<token>" \
               ansibleplaybookbundle/mysql-apb provision \
               --extra-vars mysql_database=prod \
               --extra-vars plan=prod \
               --extra-vars volume_size=2Gi

## Tearing down the application

    docker run -e "OPENSHIFT_TARGET=<openshift_api_url>" \
               -e "OPENSHIFT_TOKEN=<token>" \
               ansibleplaybookbundle/mysql-apb deprovision
