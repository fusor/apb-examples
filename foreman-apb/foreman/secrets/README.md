make-certs.sh
-------------------

Creates a self-signed CA with certificates for each service and client that
needs one. Note that Qpid requires an NSS database, which this also creates
(you're welcome). After running this, feel free to overwrite any artifacts with
your own before running `commit.sh`.

Artifacts go in directories named `certs/` and `qpiddb/`

TODO: It would be nice if you could provide your own CA but still have
everything else auto-created.


pulp-gen-key-pair
-----------------

Creates an RSA key pair in the `certs/` directory.


pulp-qpid-ssl-cfg
-----------------

This gets called by `make-certs.sh`. It creates the NSS database and associated
certificates. You should not need to run this directly.


full-server.conf
----------------

A fully-commented version of Pulp's `server.conf`. Defaults will work, but
consider such settings as the initial admin password.  For settings that are
already populated with non-default values, those values are likely important to
integration with other k8s resources. It's wise to understand the current value
before changing it.

Comments get stripped from this file by `commit.sh` before storing it in k8s.


commit.sh
---------

Creates secrets in kubernetes based on the artifacts already produced in this
directory.


delete.sh
---------

Removes all Pulp secrets from kubernetes.
