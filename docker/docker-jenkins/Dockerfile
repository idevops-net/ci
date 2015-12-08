FROM jenkins
MAINTAINER David Geng <david@esse.io>

# Install sbt
USER root
RUN apt-get update && apt-get install -y apt-transport-https
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823 && \
    apt-get update && apt-get install -y sbt python-pip python-dev build-essential gcc libxml2-dev libxslt1-dev libffi-dev libssl-dev libpq-dev && rm -rf /var/lib/apt/lists/*
RUN pip install --upgrade pip && \
    pip install --upgrade virtualenv

# Set timezone to HongKong
RUN cp /usr/share/zoneinfo/Asia/Hong_Kong /etc/localtime

USER jenkins

ENV JAVA_OPTS -Duser.timezone=Asia/Hong_Kong

# Install plugins
COPY plugins.txt /usr/local/etc/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/local/etc/plugins.txt

# Add gerrit-trigger plugin config file
COPY gerrit-trigger.xml /usr/local/etc/gerrit-trigger.xml

# Add credentials plugin config file
COPY credentials.xml /usr/local/etc/credentials.xml

# Add maven installation config file
COPY hudson.tasks.Maven.xml /usr/local/etc/hudson.tasks.Maven.xml
COPY apache-maven-3.3.3-bin.zip /usr/local/etc/apache-maven-3.3.3-bin.zip
COPY maven.installedFrom /usr/local/etc/.installedFrom

# Add Jenkins URL and system admin e-mail config file
COPY jenkins.model.JenkinsLocationConfiguration.xml /usr/local/etc/jenkins.model.JenkinsLocationConfiguration.xml

# Add Nexus repository mirror config file
COPY maven.settings.xml /usr/local/etc/settings.xml

# Add setup script.
COPY jenkins-setup.sh /usr/local/bin/jenkins-setup.sh
