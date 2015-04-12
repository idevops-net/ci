#!/bin/bash
set -x

ls ${GERRIT_HOME}
if [ -f ${GERRIT_HOME}/gerrit ]; then
    echo "Find gerrit project, need not generate it again."
else
    java -jar $GERRIT_WAR init --batch --install-plugin replication --install-plugin commit-message-length-validator -d ${GERRIT_HOME}/gerrit
fi

mkdir -p ${GERRIT_HOME}/gerrit/etc
mkdir -p /var/log/gerrit
mkdir -p ${GERRIT_HOME}/.ssh
/bin/cp -f ${GERRIT_HOME}/gerrit.config.template  ${GERRIT_HOME}/gerrit/etc/gerrit.config
git config -f $GERRIT_HOME/gerrit/etc/gerrit.config auth.type $AUTH_TYPE
git config -f $GERRIT_HOME/gerrit/etc/gerrit.config container.user $GERRIT_USER
git config -f $GERRIT_HOME/gerrit/etc/gerrit.config gerrit.canonicalWebUrl $GERRIT_URL
git config -f $GERRIT_HOME/gerrit/etc/gerrit.config ldap.server $LDAP_SERVER
git config -f $GERRIT_HOME/gerrit/etc/gerrit.config ldap.accountBase $LDAP_ACCOUNT_BASE

if [ x"true" = x${REPLICATE_ENABLED} ]; then
    sed "s#REPLICATE_SERVER#$REPLICATE_SERVER#g;s#REPLICATE_USER#$REPLICATE_USER#g" ${GERRIT_HOME}/replication.config.template > ${GERRIT_HOME}/gerrit/etc/replication.config
    cat ${GERRIT_HOME}/gerrit/etc/replication.config
    sed "s#REPLICATE_SERVER#$REPLICATE_SERVER#g;s#REPLICATE_USER#$REPLICATE_USER#g;s#REPLICATE_KEY#$REPLICATE_KEY#g" ${GERRIT_HOME}/config.template > ${GERRIT_HOME}/.ssh/config
    cat ${GERRIT_HOME}/.ssh/config
fi

#mkdir -p /etc/supervisor/conf.d/
chown -R ${GERRIT_USER}:${GERRIT_USER} ${GERRIT_HOME}

#sed "s#GERRIT_USER#$GERRIT_USER#g;s#GERRIT_HOME#$GERRIT_HOME#g" ${GERRIT_HOME}/gerrit.conf.template > /etc/supervisor/conf.d/gerrit.conf
#supervisord -c /etc/supervisor/supervisord.conf -n
sudo -u ${GERRIT_USER} $GERRIT_HOME/gerrit/bin/gerrit.sh restart

if [ $? -eq 0 ]
then
    echo "gerrit $GERRIT_VERSION is started successfully, please login to check."
    tail -f $GERRIT_HOME/gerrit/logs/httpd_log
else
    cat $GERRIT_HOME/gerrit/logs/error_log
fi

