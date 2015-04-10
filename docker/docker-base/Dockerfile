FROM centos:centos7
MAINTAINER gengjh <david.geng@idevops.net>
RUN yum clean all \
&& yum -y update \
&& yum -y install python-setuptools wget
RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm;rpm -ivh epel-release-7-5.noarch.rpm
# INSTALL SUPERVISORD
RUN yum install -y python-setuptools \
&& easy_install pip \
&& pip install supervisor \
&& mkdir /etc/supervisord.d/ \
&& mkdir -p /conf/init
# ADD SUPERVISORD CONFS
ADD files/supervisord.conf /etc/supervisord.conf
ADD files/startup.sh /conf/
RUN chmod +x /conf/startup.sh
ONBUILD ADD files/supervisord.d/* /etc/supervisord.d/
ONBUILD ADD files/init/* /conf/init/
ENTRYPOINT /conf/startup.sh

