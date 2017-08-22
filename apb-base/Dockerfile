FROM centos:7
MAINTAINER Ansible Playbook Bundle Community

LABEL "com.redhat.apb.version"="0.1.0"

ENV USER_NAME=apb \
    USER_UID=1001 \
    BASE_DIR=/opt/apb
ENV HOME=${BASE_DIR}

RUN curl https://copr.fedorainfracloud.org/coprs/g/ansible-service-broker/ansible-service-broker/repo/epel-7/group_ansible-service-broker-ansible-service-broker-epel-7.repo -o /etc/yum.repos.d/asb.repo
RUN yum -y install epel-release centos-release-openshift-origin \
    && yum -y install --setopt=tsflags=nodocs origin-clients python-openshift ansible ansible-kubernetes-modules ansible-asb-modules apb-base-scripts \
    && yum clean all

RUN mkdir -p /usr/share/ansible/openshift \
             /etc/ansible /opt/ansible \
             ${BASE_DIR}/{etc,.kube,.ansible/tmp} \
             && useradd -u ${USER_UID} -r -g 0 -M -d ${BASE_DIR} -b ${BASE_DIR} -s /sbin/nologin -c "apb user" ${USER_NAME} \
             && chown -R ${USER_NAME}:0 /opt/{ansible,apb} \
             && chmod -R g=u /opt/{ansible,apb} /etc/passwd

COPY files/etc/ansible/* /etc/ansible/
COPY files/usr/bin/* /usr/bin/

ENTRYPOINT ["entrypoint.sh"]
