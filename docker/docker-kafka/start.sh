#!/bin/bash -x

# If a ZooKeeper container is linked with the alias `zookeeper`, use it.
# TODO Service discovery otherwise
[ -n "$ZOOKEEPER_PORT_2181_TCP_ADDR" ] && ZOOKEEPER_IP=$ZOOKEEPER_PORT_2181_TCP_ADDR
[ -n "$ZOOKEEPER_PORT_2181_TCP_PORT" ] && ZOOKEEPER_PORT=$ZOOKEEPER_PORT_2181_TCP_PORT

# Necessary?

EXTENSION=""
case $BRANCH in
  master)
    EXTENSION=".prod"
    CHROOT="/kafka_v0_8_2"
  ;;
  staging)
    EXTENSION=".staging"
    CHROOT="/kafka_v0_8_2"
  ;;
  *)
    # Developer environments, etc.
    EXTENSION=".default"
  ;;
esac

IP=$(cat /etc/hosts | head -n1 | awk '{print $1}')
PORT=9092

[ -z "ZOOKEEPER_URL" ] && ZOOKEEPER_URL=${ZOOKEEPER_IP}:${ZOOKEEPER_PORT:-2181}

cat /kafka/config/server.properties${EXTENSION} \
  | sed "s|{{ZOOKEEPER_URL}}|${ZOOKEEPER_URL}|g" \
  | sed "s|{{BROKER_ID}}|${BROKER_ID:-0}|g" \
  | sed "s|{{CHROOT}}|${CHROOT:-}|g" \
  | sed "s|{{EXPOSED_HOST}}|${EXPOSED_HOST:-$IP}|g" \
  | sed "s|{{PORT}}|${PORT:-9092}|g" \
  | sed "s|{{EXPOSED_PORT}}|${EXPOSED_PORT:-9092}|g" \
   > /kafka/config/server.properties

export CLASSPATH=$CLASSPATH:/kafka/lib/slf4j-log4j12.jar
export JMX_PORT=7203

chown -R kafka:kafka /kafka /data /logs

echo "Starting kafka"
exec sudo -u kafka /kafka/bin/kafka-server-start.sh /kafka/config/server.properties
