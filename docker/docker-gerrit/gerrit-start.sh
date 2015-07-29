#!/bin/bash
set -e
#TODO:Not sure if gerrit can be stopped properly...
echo "Starting Gerrit..."
exec sudo -u ${GERRIT_USER} $GERRIT_SITE/bin/gerrit.sh daemon
