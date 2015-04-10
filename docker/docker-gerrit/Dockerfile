
FROM ubuntu:trusty

MAINTAINER David Geng <david.geng@idevops.net>

ENV GERRIT_USER gerrit2
ENV GERRIT_HOME /home/${GERRIT_USER}
ENV GERRIT_WAR ${GERRIT_HOME}/gerrit.war
ENV GERRIT_VERSION 2.9.3
ENV GERRIT_URL http://127.0.0.1

ENV AUTH_TYPE DEVELOPMENT_BECOME_ANY_ACCOUNT
ENV LDAP_SERVER ldap://127.0.0.1
ENV LDAP_ACCOUNT_BASE ou=people,dc=example,dc=com

ENV REPLICATE_ENABLED true
ENV REPLICATE_USER jenkins
ENV REPLICATE_SERVER github.com
ENV REPLICATE_KEY ${GERRIT_HOME}/.ssh/id_rsa

RUN useradd -m ${GERRIT_USER}

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jre-headless git-core
#ADD https://gerrit-releases.storage.googleapis.com/gerrit-${GERRIT_VERSION}.war /tmp/gerrit.war
ADD gerrit-${GERRIT_VERSION}.war /tmp/gerrit.war
ADD files/ssh/ssh_conf /etc/ssh/
ADD start.sh /app/
RUN mv /tmp/gerrit.war $GERRIT_WAR

WORKDIR $GERRIT_HOME

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/jre

ADD files/gerrit.config.template ${GERRIT_HOME}/
ADD files/replication.config.template ${GERRIT_HOME}/
ADD files/ssh/config.template ${GERRIT_HOME}/

EXPOSE 8080 29418

CMD ["/app/start.sh"]
