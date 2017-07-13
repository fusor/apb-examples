jenkins-apb
======================

## What it does
This APB deploys a Jenkins server capable of managing OpenShift Pipeline builds and supporting OpenShift-based
oauth login.

## Requirements

## Parameters
* persistent: Optional, if true use a persistent volume for Jenkins data.
* volume_capacity: Optional, volume space available for data, e.g. 512Mi, 2Gi.
* enable_oauth: Optional, whether to enable OAuth OpenShift integration. If false, the static account 'admin' will be initialized with the password 'password'.
* memory_limit: Optional, maximum amount of memory the container can use.
* source_git_uri: Optional, if defined with `source_git_ref` and `source_context_dir` will use source-to-image
allowing additional modifications to the Jenkins image. See https://github.com/openshift/jenkins#installing-using-s2i-build for more information.
* source_git_ref: Optional, see `source_git_uri`
* source_context_dir: Optional, see `source_git_uri`
* jenkins_image_stream_tag: Optional, Name of the ImageStreamTag to be used for the Jenkins image.
* jenkins_service_name: Optional, The name of the OpenShift Service exposed for the Jenkins container.
* jnlp_service_name: Optional, The name of the service used for master/slave communication.

## Running the application
`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" ansibleplaybookbundle/jenkins-apb provision`

## Tearing down the application
`docker run -e "OPENSHIFT_TARGET=<openshift_target>" -e "OPENSHIFT_USER=<user>" -e "OPENSHIFT_PASS=<password>" ansibleplaybookbundle/jenkins-apb deprovision`

