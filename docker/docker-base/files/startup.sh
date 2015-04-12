#!/bin/bash
for init in `ls /conf/init/*`; do
  bash "$init"
done
supervisord -c /etc/supervisord.conf -n
