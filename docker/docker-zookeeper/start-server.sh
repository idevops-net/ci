#!/bin/bash
if [ -z ${ZOO_ID} ] ; then
  echo 'No ID specified, please specify one between 1 and 255'
  exit -1
fi

if [ ! -f /opt/zookeeper/conf/zoo.cfg ] ; then
  echo 'Waiting for config file to appear...'
  while [ ! -f /opt/zookeeper/conf/zoo.cfg ] ; do
    sleep 2
  done
  echo 'Config file found, starting server.'
fi

mkdir -p /var/lib/zookeeper

echo "${ZOO_ID}" > /var/lib/zookeeper/myid

/opt/zookeeper/bin/zkServer.sh start-foreground
