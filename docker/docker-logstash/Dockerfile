FROM logstash:1.5.4

MAINTAINER David Geng <david@esse.io>

RUN wget http://rubygems.org/downloads/logstash-input-lumberjack-1.0.5.gem && /opt/logstash/bin/plugin install logstash-input-lumberjack-1.0.5.gem && rm -f logstash-input-lumberjack-1.0.5.gem

EXPOSE 9091
