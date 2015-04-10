Gerrit Docker
==========

Create Gerrit Docker image

Prepare environment
-------------------

Run the follow command before build the docker image::
    wget https://gerrit-releases.storage.googleapis.com/gerrit-2.9.3.war
    
Build image
-----------

Run ```docker build -t gerrit ./``` to build the Gerrit Docker image

Run the Docker container
------------------------

Run ```docker run -t -d -p 8080:8080 -p 29418:29418 -e AUTH_TYPE=<auth type, like LDAP, OpenID, default is 'DEVELOPMENT_BECOME_ANY_ACCOUNT'> -e GERRIT_URL=<Gerrit Web url> -e LDAP_SERVER=<LDAP server, only valid on auth type is LDAP> -e LDAP_ACCOUNT_BASE=<LDAP account base string> -e REPLICATE_USER=<replication user, it should valid in the remote server> -e REPLICATE_KEY=<the ssh key name which is used by replication user> -v <your gerrit data dir if you already have it>:/home/gerrit2/gerrit -v <your ssh key which is used to replicate repositories>:/home/gerrit2/.ssh gerrit``` to start Gerrit container

For the AUTH_TYPE, see [official documentation](https://gerrit-documentation.storage.googleapis.com/Documentation/2.9.3/config-gerrit.html#auth)

The Gerrit web site listen on port `8080`.

The Gerrit service listen on port `29418`.

Example
-------

    $ docker run -t -d -p 8080:8080 -p 29418:29418 -e AUTH_TYPE=LDAP -e GERRIT_URL=http://review.idevops.net:33080 -e LDAP_SERVER=ldap://ldap.idevops.net -e LDAP_ACCOUNT_BASE="ou=people,dc=idevops,dc=net" -e REPLICATE_USER=idevops-ci -e REPLICATE_KEY=/home/gerrit2/.ssh/ci_rsa -v /home/gengjh/gerrit:/home/gerrit2/gerrit -v /home/gengjh/ssh_key:/home/gerrit2/.ssh gerrit
