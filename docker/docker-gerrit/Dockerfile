FROM java:openjdk-7-jre

MAINTAINER David <david@esse.io>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libcgi-pm-perl \
    gitweb \
    sudo \
  && rm -rf /var/lib/apt/lists/*
ENV GERRIT_HOME /var/gerrit
ENV GERRIT_SITE ${GERRIT_HOME}/review_site
ENV GERRIT_WAR ${GERRIT_HOME}/gerrit.war
ENV GERRIT_VERSION 2.11.2
ENV GERRIT_USER gerrit2
ENV REPLICATE_ENABLED true
ENV REPLICATE_USER git
ENV REPLICATE_SERVER github.com
ENV REPLICATE_KEY ${GERRIT_HOME}/.ssh/id_rsa
ENV RP_SERVER_PORT 22
ENV RE_AUTHGROUP Administrators

RUN useradd -m -d "$GERRIT_HOME" -u 1000 -U  -s /bin/bash $GERRIT_USER

#Download gerrit.war
#RUN curl -L https://gerrit-releases.storage.googleapis.com/gerrit-${GERRIT_VERSION}.war -o $GERRIT_WAR
#Only for local test
COPY gerrit-${GERRIT_VERSION}.war $GERRIT_WAR

COPY gerrit-entrypoint.sh ${GERRIT_HOME}/
COPY gerrit-start.sh ${GERRIT_HOME}/

RUN chmod +x ${GERRIT_HOME}/gerrit*.sh

#A directory has to be created before a volume is mounted to it.
#So gerrit user can own this directory.
RUN mkdir -p $GERRIT_SITE

COPY files/replication.config.template ${GERRIT_HOME}/
COPY files/ssh/config.template ${GERRIT_HOME}/
COPY files/ssh/ssh_conf /etc/ssh/

#Gerrit site directory is a volume, so configuration and repositories
#can be persisted and survive image upgrades.
VOLUME $GERRIT_SITE

ENTRYPOINT ["/var/gerrit/gerrit-entrypoint.sh"]

EXPOSE 8080 29418

CMD ["/var/gerrit/gerrit-start.sh"]

