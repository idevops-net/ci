Docker Base Image
==========

Create Docker base image
------------------------

You need create this base image before build all others (under the https://github.com/idevops-net/ci/tree/master/docker/).

The other docker images based on this one need prepare the init script and supervisord config file which are used to init environment, prepare configuration files and run command when we start the container.

For example::
    https://github.com/idevops-net/ci/blob/master/docker/docker-zuul/files/init/init-zuul-config
    https://github.com/idevops-net/ci/blob/master/docker/docker-zuul/files/supervisord.d/zuul.conf

Build image
-----------

Run ```docker build -t centos7 ./``` to build the Docker base image


