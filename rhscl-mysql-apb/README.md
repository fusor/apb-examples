rhscl-mysql-apb
===============

An Ansible Playbook Bundle (APB) to deploy [MySQL](https://www.mysql.com).

## What it does
* It deploys a MySQL using the
  [Software Collections (SCL) image for MySQL](https://github.com/sclorg/mysql-container/)

## Requirements
* N/A

## Parameters

* mysql_database: MySQL database name (default: 'devel')
* mysql_password: MySQL database password (default: randomly generated)
* mysql_user: MySQL database username (default: 'devel')
* mysql_version: MySQL version to deploy. 5.6 and 5.7 are available (default: '5.7')
* persistent_storage: wether to allocate a Persistent Volume Claim for MySQL data (default: true)
* volume_size: size of the PVC to request if persistent_storage is requested (default: '1Gi')
* service_name: name of the service, used for names and labels of provisioned resources (default: 'mysql')
* namespace: target namespace/project where resources will be provisioned (default: 'rhscl-mysql-apb')

### Environment variables

For convenience, the parameters above can be set/overriden via environment variables on the APB container. The environment variable names are the same in all upper case letters; for example, you can specify the `namespace` parameter via the `NAMESPACE` environment variable.

## Running the application

    docker run -e "OPENSHIFT_TARGET=<openshift_api_url>" \
               -e "OPENSHIFT_TOKEN=<token>" \
               ansibleplaybookbundle/mysql-apb provision

You can pass additional parameters to `ansible-playbook` by adding them at the end; for example, you can request more verbose output with one or more `-v` and pass additional variables with `--extra-vars`.

    docker run -e "OPENSHIFT_TARGET=<openshift_api_url>" \
               -e "OPENSHIFT_TOKEN=<token>" \
               ansibleplaybookbundle/mysql-apb provision \
               --extra-vars mysql_database=devel \
               --extra-vars volume_size=2Gi

## Tearing down the application

    docker run -e "OPENSHIFT_TARGET=<openshift_api_url>" \
               -e "OPENSHIFT_TOKEN=<token>" \
               ansibleplaybookbundle/mysql-apb deprovision
