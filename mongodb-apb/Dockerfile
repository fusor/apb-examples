FROM ansibleplaybookbundle/apb-base

LABEL "com.redhat.apb.version"="0.1.0"

COPY provision.yml deprovision.yml test.yml /opt/apb/actions/
COPY roles /opt/ansible/roles
RUN chmod -R g=u /opt/{ansible,apb}
USER apb
