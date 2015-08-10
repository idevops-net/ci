FROM debian:jessie
MAINTAINER David Geng

ENV ZOO_VERSION 3.4.6
ENV ZOO_ID 0

RUN apt-get update && apt-get install -y openjdk-7-jre-headless wget
RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-${ZOO_VERSION}/zookeeper-${ZOO_VERSION}.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-${ZOO_VERSION} /opt/zookeeper \
    && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
    && mkdir -p /tmp/zookeeper

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/var/lib/zookeeper"]

ADD start-server.sh /tmp/
RUN chmod +x /tmp/start-server.sh
ENTRYPOINT ["/tmp/start-server.sh"]
