# Gerrit Docker image
 The Gerrit code review system with PostgreSQL, OpenLDAP integration and replication supported.

## Prepare environment
  Run the follow command before build the docker image:
   
    `$ wget https://gerrit-releases.storage.googleapis.com/gerrit-2.11.2.war`

## Build image
  Run ```docker build -t gerrit ./``` to build the Gerrit Docker image

## Container Quickstart
  1. Initialize and start gerrit.

    `$ docker run -d -p 8080:8080 -p 29418:29418 gerrit`

  2. Open your browser to http://<docker host url>:8080

## Use another container as the gerrit site storage.
  1. Create a volume container.

    `docker run --name gerrit_volume gerrit echo "Gerrit volume container."`

  2. Initialize and start gerrit using volume created above.

    `docker run -d --volumes-from gerrit_volume -p 8080:8080 -p 29418:29418 gerrit`

## Use local directory as the gerrit site storage.
  1. Create a site directory for the gerrit site.

    `mkdir ~/gerrit_volume`

  2. Initialize and start gerrit using the local directory created above.

    `docker run -d -v ~/gerrit_volume:/var/gerrit/review_site -p 8080:8080 -p 29418:29418 gerrit`

## Run dockerized gerrit with dockerized PostgreSQL and OpenLDAP.
#####All attributes in [gerrit.config ldap section](https://gerrit-review.googlesource.com/Documentation/config-gerrit.html#ldap) is supported.

    #Start sameersbn/postgresql docker
    docker run \
    --name pg-gerrit \
    -p 5432:5432 \
    -e DB_USER=gerrit2 \
    -e DB_PASS=gerrit \
    -e DB_NAME=reviewdb \
    -d sameersbn/postgresql
    #Start gerrit docker
    docker run \
    --name gerrit \
    --link pg-gerrit:db \
    -p 8080:8080 \
    -p 29418:29418 \
    -e WEBURL=http://<your.site.url>:8080 \
    -e DATABASE_TYPE=postgresql \
    -e AUTH_TYPE=LDAP \
    -e LDAP_SERVER=<ldap-servername> \
    -e LDAP_ACCOUNTBASE=<ldap-basedn> \
    -e LDAP_ACCOUNTPATTERN=(mail=${username}) \
    -e LDAP_ACCOUNTFULLNAME=displayName \
    -e LDAP_ACCOUNTEMAILADDRESS=mail \
    -e LDAP_REFERRAL=follow
    -d gerrit

```
You need specify the following environment variables when run docker container if you do not link the postgresal

    DB_PORT_5432_TCP_ADDR: database hostname
    DB_PORT_5432_TCP_PORT: database port
    DB_ENV_DB_NAME: database name
    DB_ENV_DB_USER: database username
    DB_ENV_DB_PASS: database password
```

## Sync timezone with the host server. 
   `docker run -d -p 8080:8080 -p 29418:29418 -v /etc/localtime:/etc/localtime:ro gerrit`

## Enable the replication

    docker run \
    docker run -t -d -p 8080:8080 -p 29418:29418 \
    -e REPLICATE_ENABLED=true \
    -e REPLICATE_USER=<git.replication.user> \
    -e REPLICATE_KEY=<replication.user.ssh.private.key.filename> \
    -v <your.gerrit.local.data.dir>:/var/gerrit/review_site \
    -v <replication.user.ssh.key.local.data.dir>:/var/gerrit/.ssh \

