FROM centos:7
MAINTAINER Ansible Playbook Bundle Community

LABEL "com.redhat.apb.version"="0.1.0"

ENV USER_NAME=apb \
    USER_UID=1001 \
    BASE_DIR=/opt/apb
ENV HOME=${BASE_DIR}

RUN curl https://copr.fedorainfracloud.org/coprs/g/ansible-service-broker/ansible-service-broker/repo/epel-7/group_ansible-service-broker-ansible-service-broker-epel-7.repo -o /etc/yum.repos.d/asb.repo
RUN yum -y install epel-release centos-release-openshift-origin \
    && yum -y install --setopt=tsflags=nodocs origin-clients python-openshift ansible ansible-kubernetes-modules apb-base-scripts \
    && yum clean all

RUN mkdir -p /usr/share/ansible/openshift \
             /etc/ansible-service-broker \
             /etc/ansible /opt/ansible \
             ${BASE_DIR} ${BASE_DIR}/etc \
             ${BASE_DIR}/.kube ${BASE_DIR}/.ansible/tmp && \
             useradd -u ${USER_UID} -r -g 0 -M -d ${BASE_DIR} -b ${BASE_DIR} -s /sbin/nologin -c "apb user" ${USER_NAME} && \
             chown -R ${USER_NAME}:0 /opt/{ansible,apb} && \
             chown -R ${USER_NAME}:0 /etc/ansible-service-broker && \
             chmod -R g+rw /opt/{ansible,apb} ${BASE_DIR} /etc/passwd

RUN echo "localhost ansible_connection=local" > /etc/ansible/hosts \
    && echo '[defaults]' > /etc/ansible/ansible.cfg \
    && echo 'roles_path = /etc/ansible/roles:/opt/ansible/roles' >> /etc/ansible/ansible.cfg

COPY oc-login.sh entrypoint.sh broker-bind-creds bind-init /usr/bin/

RUN sed "s@${USER_NAME}:x:${USER_UID}:@${USER_NAME}:x:\${USER_ID}:@g" /etc/passwd > ${BASE_DIR}/etc/passwd.template
ENTRYPOINT ["entrypoint.sh"]
