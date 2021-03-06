FROM relateiq/oracle-java7
MAINTAINER David Geng <david@esse.io>

RUN mkdir /kafka /data /logs

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates \
    sudo

ENV KAFKA_RELEASE_ARCHIVE kafka_2.10-0.8.2.1.tgz

# Download Kafka binary distribution
ADD http://www.us.apache.org/dist/kafka/0.8.2.1/${KAFKA_RELEASE_ARCHIVE} /tmp/
ADD https://dist.apache.org/repos/dist/release/kafka/0.8.2.1/${KAFKA_RELEASE_ARCHIVE}.md5 /tmp/

WORKDIR /tmp

# Check artifact digest integrity
RUN echo VERIFY CHECKSUM: && \
  gpg --print-md MD5 ${KAFKA_RELEASE_ARCHIVE} 2>/dev/null && \
  cat ${KAFKA_RELEASE_ARCHIVE}.md5

# Install Kafka to /kafka
RUN tar -zx -C /kafka --strip-components=1 -f ${KAFKA_RELEASE_ARCHIVE} && \
  rm -rf kafka_*

ADD http://repo1.maven.org/maven2/org/slf4j/slf4j-log4j12/1.7.6/slf4j-log4j12-1.7.6.jar /kafka/libs/
ADD config /kafka/config
ADD start.sh /start.sh

# Set up a user to run Kafka
RUN groupadd kafka && \
  useradd -d /kafka -g kafka -s /bin/false kafka 

ENV PATH /kafka/bin:$PATH
WORKDIR /kafka

# primary, jmx
EXPOSE 9092 7203
VOLUME [ "/data", "/logs" ]

CMD ["/start.sh"]

