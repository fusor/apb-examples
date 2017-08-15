# apb-examples
[![Build Status](https://travis-ci.org/fusor/apb-examples.svg?branch=master)](https://travis-ci.org/fusor/apb-examples)

A repository of example ansible-playbook bundles (APBs)

# APB Documentation
Documents to get started on writing APBs.
  * [Introduction](https://github.com/fusor/ansible-playbook-bundle/blob/master/docs/README.md)
  * [Getting Started 'Hello-World' APB](https://github.com/fusor/ansible-playbook-bundle/blob/master/docs/getting_started.md)
  * [Developer's Guide](https://github.com/fusor/ansible-playbook-bundle/blob/master/docs/developers.md)

# Index
  * [Requirements](#requirements)
    * [Directory Structure](#directory-structure)
      * [Minimal](#required-minimal-structure)
      * [With Optional Files](#directory-structure-with-optional-files)
      * [Example Files](#example-files)
    * [Dockerfile Validation](#dockerfile-validation)
    * [Building the APB](#building-the-apb)
    * [Running the APB](#running-the-apb)
  * [Contributing](#contributing-to-apb-examples)
  * [Getting Help](#getting-help)

# Requirements
Review all of the documents linked [above](#apb-documentation).  It details how the [APB tooling](https://github.com/fusor/ansible-playbook-bundle/blob/master/src/README.md) may help in creating APBs. Be sure to complete all of the requirements below.

## APB Name Example
The name `my-apb` will be used as an example for the rest of this document.

## Dockerfiles and Tags
There are three tags can expect to see on most APB repos under the ansibleplaybookbundle project.
- **Canary**: Automated images build from source. These are generally intended to help work on development of the ansible-service-broker and can be expected to break frequently.
- **Latest**: Stable images released less frequently and expected to work with the latest ansible-service-broker. A few of these are built using only RPMS while others are built from source.
- **Nightly**: Automated image builds using automated RPM builds. This tag is intended to ensure RPM builds for those APB's roles being packaged work on an ongoing basis. As of right now this is limited to:
  - apb-base
  - mediawiki-apb
  - rhscl-postgresql-apb
- As time goes on and releases are made we may also create tags for specified versions, for example, 1.0, 1.1, etc.

In some directories you will see just one Dockerfile. In general this will indicate images are being built for the latest and canary tags. In a few directories you will see multiple Dockerfiles. In these cases they will have a suffix like -canary, -latest, -nightly, etc. to differentiate which tag it is being used to build. Where there are multiple Dockerfiles, canary is likely to be preferable for rapid development.

In these cases, be aware that to rebuild canary images using the canary apb-base image you'll need to update the from line to read `ansibleplaybookbundle/apb-base:canary` rather than `ansibleplaybookbundle/apb-base:latest`

By default the Ansible Service Broker will deploy APB's using the latest tag, but it is possible to specify an alternate tag per registry. When using catasb this can be done by specifying apbtag in your my_vars.yaml config file.

## Directory Structure

### Required Minimal Structure
The directory structure of `my-apb` APB, with all it's required files, would look like the following:
```bash
my-apb/
├── apb.yml
├── Dockerfile
├── playbooks
│   └── provision.yml
│   └── deprovision.yml
└── roles
    └── my-apb-openshift
        ├── defaults
        │   └── main.yml
        ├── tasks
            └── main.yml
```
### Directory Structure with Optional Files
The directory structure with _optional/additional_ files, may look like this:
```bash
my-apb/
├── apb.yml
├── Dockerfile
├── playbooks
│   └── provision.yml
│   └── deprovision.yml
└── roles
    └── my-apb-openshift
        ├── defaults
        │   └── main.yml
        ├── files
        │   └── <my-apb files>    (optional)
        ├── README                (optional)
        ├── tasks
        │   └── main.yml
        └── templates             (optional)
            └── <template files>
```

In most cases you will see just one Dockerfile. In general this will be used for the canary and latest tags. 

In a few cases, where the apb role has been packaged as an rpm you will likely see multiple Dockerfiles with a suffix to differentiate which tags they are used to generate images for.

### Example Files
#### `Dockerfile`
```bash
FROM ansibleplaybookbundle/apb-base

LABEL "com.redhat.apb.version"="0.1.0"
LABEL "com.redhat.apb.spec"="some-long-blob-value"

ADD playbooks /opt/apb/actions
ADD roles /opt/ansible/roles
RUN chmod -R g=u /opt/{ansible,apb}

USER apb
```
- [Hello World Dockerfile](hello-world-apb/Dockerfile)

#### Spec File (`apb.yml`)
```bash
id: 12345678-abcd-efgh-ijkl-mnopqrstuvwx
name: my-apb
image: my-org/my-apb
description: "my-apb description"
bindable: false
async: optional
parameters: []
```
- [Hello World apb.yml](hello-world-apb/apb.yml)

#### `provision.yml`
```bash
- name: my-apb provision
  hosts: localhost
  gather_facts: false
  connection: local
  roles:
  - role: ansible.kubernetes-modules
    install_python_requirements: no
  - role: my-apb-openshift
    playbook_debug: false
```
- [Hello World provision.yml](hello-world-apb/playbooks/provision.yml)

#### `deprovision.yml`
```bash
TODO
```

#### Other Files
For examples of other files, review the [`hello-world-apb`](https://github.com/fusor/apb-examples/tree/master/hello-world-apb) repo


## `Dockerfile` Validation
APB's `Dockerfile` contain a `LABEL` that specifies the base64 encoded value of the APB's spec file, namely its `apb.yml` file, which looks as like this:
```bash
LABEL "com.redhat.apb.spec"="<base64-encoded-apb.yml-file-blob-value>"
```

This value is generated by running the [`apb prepare`](https://github.com/fusor/ansible-playbook-bundle/blob/master/src/README.md#prepare) command inside the APB source folder. Before submitting a PR, be sure to run the `apb prepare` command so that the APB's `Dockerfile` is up-to-date with its `apb.yml` spec file.  

## Building the APB
To build `my-apb`, execute the following command
```bash
$ cd my-apb
$ docker build -t my-apb .
```
## Running the APB
To run `my-apb`, make sure that a test OpenShift/Origin cluster is accessible.

For example, assuming the below environment...
```bash
OpenShift URL        : `https://172.17.0.1.nip.io:8443`
OpenShift Token      : WoCG534Mh9O2AyT_mFn3uKQ6R9-fuk_Rsr-oF4K8Pqw
OpenShift Namespace  : my-apb (via `--extra-vars`)
APB Image Entrypoint : /usr/bin/entrypoint.sh
APB Action           : provision
```

To get your OpenShift Token, type `oc whoami -t`

The following command can be executed to `provision` the `my-apb`:
```bash
$ docker run \
--entrypoint /usr/bin/entrypoint.sh \
-e "OPENSHIFT_TARGET=https://172.17.0.1.nip.io:8443" \
-e "OPENSHIFT_TOKEN=WoCG534Mh9O2AyT_mFn3uKQ6R9-fuk_Rsr-oF4K8Pqw" \
   my-apb \
   provision \
   --extra-vars 'namespace=my-apb'
```

# Contributing a new APB to apb-examples
  * Create a new directory for the app and add playbooks
  * Make a [pull request](https://help.github.com/articles/using-pull-requests)
  * Someone will ACK your PR in the review thread
  * Someone will then Merge your PR
  * After merging, create an automated build for the APB in [dockerhub](https://docs.docker.com/docker-hub/builds/)
  * Under Build Settings, create a build tagged 'latest' and 'canary'
  * Link the APB build to the apb-base container by adding 'ansibleplaybookbundle/apb-base' as a Repository Link


# Getting Help
  * #asbroker - freenode
  * [Email Us](mailto:ansible-service-broker@redhat.com)
