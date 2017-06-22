# pyzip-demo-db-apb
A [PostgreSQL](https://www.postgresql.org) APB for the demo [Python Zipcode App](https://github.com/fusor/py-zip-demo)

## What it does
Deploys a postgresql container with seeded [data](./roles/provision-pyzip-demo-db-apb/files/)

## Parameters
Name | Default Value | Required | Description
---|---|---|---
postgresql_database | admin | Yes | Postgresql database name
postgresql_user | admin | Yes | Postgresql database username
postgresql_password | admin | No | Postgresql database password

## Environment Variables
Name | Default Value | Description
---|---|---
NAMESPACE | pyzip-demo-db-apb | Namespace to deploy the cluster in
POSTGRESQL_SERVICE_NAME | postgresql | Service name for PostgreSQL
