rhscl-mysql-apb
===============

An Ansible Playbook Bundle (APB) to deploy [MySQL](https://www.mysql.com).

## What it does
* It deploys a MySQL using the
  [Software Collections (SCL) image for MySQL](https://github.com/sclorg/mysql-container/)

## Requirements
* N/A

## Parameters

* mysql_database, Optional, default 'devel', MySQL database name.
* mysql_password, Optional, default is a randomly generated string, MySQL databaase password.
* mysql_user, Optional, default 'devel', MySQL database username.
* mysql_version, Optional, default '5.7', MySQL version.

## Environment variables

* NAMESPACE: Optional, default 'rhscl-mysql-apb', Namespace to deploy the cluster in.

## Running the application
`docker run -e "OPENSHIFT_TARGET=<openshift_api_url>" -e "OPENSHIFT_TOKEN=<token>" ansibleplaybookbundle/mysql-apb provision`

## Tearing down the application
`docker run -e "OPENSHIFT_TARGET=<openshift_api_url>" -e "OPENSHIFT_TOKEN=<token>" ansibleplaybookbundle/mysql-apb deprovision`
