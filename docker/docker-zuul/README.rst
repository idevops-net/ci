Zuul Docker
==========

Create Zuul Docker image

Prepare environment
-------------------

Run the follow command before build the docker image::
    git clone git://git.openstack.org/openstack-infra/zuul
    
    wget https://github.com/downloads/yui/yuicompressor/yuicompressor-2.4.7.zip; unzip yuicompressor-2.4.7.zip -d .
    
    pushd ./ && cd zuul/etc/status/ && ./fetch-dependencies.sh && popd
    
    java -jar yuicompressor-2.4.7/build/yuicompressor-2.4.7.jar -o zuul/etc/status/public_html/jquery-visibility.min.js zuul/etc/status/public_html/jquery-visibility.js
    
Install Gearman plugin in Jenkins and add at least one node in Jenkins (Gearman plugin doesnot support run jobs on master)

Build image
-----------

Run ```docker build -t zuul ./``` to build the Zuul Docker image

Run the Docker container
------------------------

Run ```docker run -d -e GERRIT_SERVER=<gerrit ip address> -e GERRIT_URL=<gerrit url> -e JENKINS_SSH_KEY=<the name of the private ssh key> -v <your ssh key which will used by zuul to access gerrit>:/home/jenkins/.ssh -v <your zuul layout configuration path>:/etc/zuul-layout -p 4730:4730 -p 8880:8880 -p 8001:8001 -p 8443:8443 zuul``` to start the zuul service.

.. seealso:: The idevops Zuul configuration for a comprehensive example: https://github.com/idevops-net/ci/tree/master/project-config/zuul/layout.yaml

The internal gearman listen on port `4730`.

The zuul server listen on port `8001`.

The httpd listen on port `8880`.

The httpd SSL listen on port `8443`.
