FROM apb/apb-base
# MAINTAINER {{ $MAINTAINER }}

LABEL "com.redhat.apb.version"="0.1.0"
LABEL "com.redhat.apb.spec"=\
"aWQ6IDliNzBlNmJmLTI2ZjgtNGMxZi1hNTdmLTA3NTAxMzg4YzFlOApuYW1lOiBhbnNpYmxlYXBw\
L3dvcmRwcmVzcy1oYS1hbnNpYmxlYXBwCmRlc2NyaXB0aW9uOiBoaWdoIGF2YWlsYWJpbGl0eSB3\
b3JkcHJlc3MgZGVwbG95bWVudApiaW5kYWJsZTogdHJ1ZQphc3luYzogIm9wdGlvbmFsIgpwYXJh\
bWV0ZXJzOgogIC0gbmFtZTogcHJvamVjdF9uYW1lCiAgICBkZXNjcmlwdGlvbjogTmFtZXNwYWNl\
IHRvIGRlcGxveSBjb250YWluZXJzIHRvCiAgICBkZWZhdWx0OiB3b3JkcHJlc3MtaGEK"
ADD roles /opt/ansible/roles
ADD apb /opt/apb

RUN useradd -u 1001 -r -g 0 -M -b /opt/apb -s /sbin/nologin -c "apb user" apb
RUN chown -R 1001:0 /opt/{ansible,apb}
USER 1001
