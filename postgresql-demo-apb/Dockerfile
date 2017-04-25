FROM ansibleplaybookbundle/apb-src-base
# MAINTAINER {{ $MAINTAINER }}

LABEL "com.redhat.apb.version"="0.1.0"
LABEL "com.redhat.apb.spec"=\
"aWQ6IDI2MzU1ZDFhLTAzMDEtNDg0MS04NWFmLTUzNmE0ZDNhZmFhOQpuYW1lOiBhbnNpYmxlYXBw\
L3Bvc3RncmVzcWwtYW5zaWJsZWFwcApkZXNjcmlwdGlvbjogUG9zdGdyZVNRTCBhbnNpYmxlYXBw\
IGltcGxlbWVudGF0aW9uCmJpbmRhYmxlOiBmYWxzZQphc3luYzogb3B0aW9uYWwKcGFyYW1ldGVy\
czoKICAtIG5hbWU6IG5hbWVzcGFjZQogICAgZGVzY3JpcHRpb246IE5hbWVzcGFjZSB0byBkZXBs\
b3kgdGhlIGNsdXN0ZXIgdG8KICAgIHR5cGU6IHN0cmluZwogICAgZGVmYXVsdDogcG9zdGdyZXNx\
bC1hbnNpYmxlYXBwCiAgLSBuYW1lOiBwb3N0Z3Jlc3FsX2RhdGFiYXNlCiAgICBkZXNjcmlwdGlv\
bjogcG9zdGdyZXNxbCBkYXRhYmFzZSBuYW1lCiAgICB0eXBlOiBzdHJpbmcKICAgIGRlZmF1bHQ6\
IGFkbWluCiAgLSBuYW1lOiBwb3N0Z3Jlc3FsX3Bhc3N3b3JkCiAgICBkZXNjcmlwdGlvbjogcG9z\
dGdyZXNxbCBkYXRhYmFzZSBwYXNzd29yZAogICAgdHlwZTogc3RyaW5nCiAgICBkZWZhdWx0OiBh\
ZG1pbgogIC0gbmFtZTogcG9zdGdyZXNxbF91c2VyCiAgICBkZXNjcmlwdGlvbjogcG9zdGdyZXNx\
bCBkYXRhYmFzZSB1c2VybmFtZQogICAgdHlwZTogc3RyaW5nCiAgICBkZWZhdWx0OiBhZG1pbgo=\
"

ADD roles /opt/ansible/roles
ADD playbooks /opt/apb/actions

RUN yum install -y postgresql && yum clean all
RUN pip install urllib3 boto

RUN useradd -u 1001 -r -g 0 -M -b /opt/apb -s /sbin/nologin -c "apb user" apb
RUN chown -R 1001:0 /opt/{ansible,apb}
USER 1001
