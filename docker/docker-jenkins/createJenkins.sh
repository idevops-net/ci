#!/bin/bash
set -e
JENKINS_NAME=${JENKINS_NAME:-jenkins}
JENKINS_VOLUME=${JENKINS_VOLUME:-jenkins-volume}
GERRIT_NAME=${GERRIT_NAME:-gerrit}
JENKINS_IMAGE_NAME=${JENKINS_IMAGE_NAME:-openfrontier/jenkins}
JENKINS_OPTS=${JENKINS_OPTS:---prefix=/jenkins}
LINK_GERRIT=true

# Create Jenkins volume.
if [ -z "$(docker ps -a | grep ${JENKINS_VOLUME})" ]; then
    docker run \
    --name ${JENKINS_VOLUME} \
    ${JENKINS_IMAGE_NAME} \
    echo "Create Jenkins volume."
fi

# Start Jenkins.
if [ x"$LINK_GERRIT" = x"true" ]; then
  docker_opt="--link ${GERRIT_NAME}:gerrit"
else
  docker_opt="-e GERRIT_NAME=${GERRIT_NAME}"
fi

docker run \
--name ${JENKINS_NAME} \
${docker_opt} \
-p 50000:50000 \
--volumes-from ${JENKINS_VOLUME} \
-d ${JENKINS_IMAGE_NAME} ${JENKINS_OPTS}
