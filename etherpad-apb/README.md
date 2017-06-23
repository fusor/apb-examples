etherpad-ansibleapp
======================

An apb for deploying [etherpad lite](https://github.com/ether/etherpad-lite).  
Adapted from https://github.com/yatesr/playbook-etherpad

## What it does
* Installs nodejs, mysql-server, nginx, etherpad-lite.
* Deploys etherpad application to Openshift

## Requirements
* Must have docker installed and parameters to authenticate against OCP cluster

## Vars and setup
* TODO

## Running the application
`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" ansibleapp/etherpad-ansibleapp provision`
## Tearing down the application
`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" ansibleapp/etherpad-ansibleapp deprovision`


TODO:  
  Vars
