# pyzip-demo-db-apb
A Demo Database APB for the [Python Zipcode App](https://github.com/fusor/py-zip-demo)

## What it does
Deploys a demo database container with seeded [data](./roles/provision-pyzip-demo-db-apb/files/)

## Parameters
Name | Default Value | Required | Description
---|---|---|---
database_name | admin | Yes | database name
database_user | admin | Yes | database username
database_password | admin | No | database password

## Environment Variables
Name | Default Value | Description
---|---|---
NAMESPACE | pyzip-demo-db-apb | Namespace to deploy the cluster in
DBSERVICE_NAME | dbservice | Service name for database
