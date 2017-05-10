FROM centos:7
MAINTAINER Ansible Playbook Bundle Community

LABEL "com.redhat.apb.version"="0.1.0"

RUN mkdir -p /root/.kube /usr/share/ansible/openshift \
            /etc/ansible /opt/apb /opt/ansible
COPY config /root/.kube/config
RUN curl https://copr.fedorainfracloud.org/coprs/jmontleon/asb/repo/epel-7/jmontleon-asb-epel-7.repo -o /etc/yum.repos.d/asb.repo
RUN yum -y install epel-release centos-release-openshift-origin \
    && yum -y update \
    && yum -y install origin-clients python-openshift ansible ansible-kubernetes-modules pwgen \
    && yum clean all

RUN echo "localhost ansible_connection=local" > /etc/ansible/hosts \
    && echo '[defaults]' > /etc/ansible/ansible.cfg \
    && echo 'roles_path = /etc/ansible/roles:/opt/ansible/roles' >> /etc/ansible/ansible.cfg

COPY oc-login.sh entrypoint.sh /usr/bin/

RUN useradd -u 1001 -r -g 0 -M -b /opt/apb -s /sbin/nologin -c "apb user" apb
RUN chown -R apb: /opt/{ansible,apb}

ENTRYPOINT ["entrypoint.sh"]
