FROM centos7
MAINTAINER gengjh <david.geng@idevops.net>

# INSTALL ZUUL
RUN yum clean all && yum install -y gcc make gcc-c++ python-devel libyaml-devel git
#&& pip install zuul \
ADD zuul /tmp/zuul/
RUN cd /tmp/zuul; pip install -U -r requirements.txt; python setup.py install

# Install gearman
#RUN yum install -y java \
#&& pip install gearman

# Configure zuul
RUN mkdir -p /var/log/zuul/ \
&& mkdir -p /etc/zuul \
&& mkdir -p /var/lib/zuul/www \
&& mkdir -p /var/lib/zuul/ssh \
&& mkdir -p /var/lib/zuul/git \
&& mkdir -p /home/jenkins/.ssh
ADD files/etc/zuul /etc/zuul/
ADD files/etc/ssh/ssh_config /etc/ssh/

RUN cp -rf /tmp/zuul/etc/status /etc/zuul/
RUN ln -s /etc/zuul/status/public_html/jquery-visibility.min.js /var/lib/zuul/www/jquery-visibility.min.js \
&& ln -s /etc/zuul/status/public_html/jquery.min.js /var/lib/zuul/www/ \
&& ln -s /etc/zuul/status/public_html/bootstrap /var/lib/zuul/www/ \
&& ln -s /etc/zuul/status/public_html/jquery.graphite.js /var/lib/zuul/www/ \
&& ln -s /etc/zuul/status/public_html/index.html /var/lib/zuul/www/ \
&& ln -s /etc/zuul/status/public_html/styles /var/lib/zuul/www/ \
&& ln -s /etc/zuul/status/public_html/zuul.app.js /var/lib/zuul/www/ \
&& ln -s /etc/zuul/status/public_html/jquery.zuul.js /var/lib/zuul/www/ \
&& ln -s /etc/zuul/status/public_html/images /var/lib/zuul/www/

# Install httpd
RUN yum install -y httpd cronie
ADD files/etc/httpd/conf.d/zuul.idevops.net.conf.template /tmp/
ADD files/etc/httpd/httpd.conf /etc/httpd/conf/
ADD files/etc/default/zuul.template /tmp/

ENV GERRIT_SERVER 127.0.0.1
ENV GERRIT_URL http://127.0.0.1
ENV JENKINS_SSH_KEY /home/jenkins/.ssh/id_rsa
ENV STATSD_HOST 127.0.0.1
ENV STATSD_PORT 8125
ENV ZUUL_GIT_URL http://zuul.idevops.net:33080
ENV ZUUL_GIT_HOST zuul.ideviops.net
VOLUME ['/home/jenkins/.ssh', '/etc/zuul-layout']
EXPOSE 4730 8001 8880 8443
