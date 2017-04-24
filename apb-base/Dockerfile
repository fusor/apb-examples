# Pastebin wNTPjTND
FROM centos:7
# MAINTAINER {{ $MAINTAINER }}

LABEL "com.redhat.apb.version"="0.1.0"

RUN mkdir -p /root/.kube
COPY config /root/.kube/config
RUN yum -y update \
 && yum -y install epel-release centos-release-openshift-origin \
 && yum -y install origin origin-clients net-tools bind-utils \
 && yum install -y python-setuptools python-pip gcc python-devel python-cffi openssl-devel \
 && yum clean all

RUN git clone https://github.com:/ansible/ansible.git
RUN cd ansible \
 && pip install -U setuptools \
 && git checkout devel \
 && python setup.py install

RUN git clone https://github.com/openshift/openshift-restclient-python
RUN cd openshift-restclient-python \
 && pip install -r requirements.txt \
 && python setup.py develop \
 && source ../ansible/hacking/env-setup
RUN openshift-ansible-gen modules

RUN mkdir -p /usr/share/ansible/openshift
RUN mkdir /etc/ansible
RUN cp _modules/*.py /usr/share/ansible/openshift
RUN echo "localhost ansible_connection=local" > /etc/ansible/hosts
RUN echo 'roles_path = /opt/ansible/roles' > /etc/ansible/ansible.cfg
RUN echo 'library = /usr/share/ansible/openshift' >> /etc/ansible/ansible.cfg

RUN mkdir /opt/apb

COPY oc-login.sh /usr/bin
COPY entrypoint.sh /usr/bin

ENTRYPOINT ["entrypoint.sh"]
