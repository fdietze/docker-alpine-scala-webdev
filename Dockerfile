FROM openjdk:8-jre-alpine3.9

ENV DEPS /deps
ENV PATH $PATH:$DEPS/sbt/bin
ENV SBT_VERSION 1.2.8
ENV SCALA_VERSION 2.12.8

# sbt
RUN apk add --no-cache bash
RUN mkdir -p $DEPS
RUN cd $DEPS && wget https://sbt-downloads.cdnedge.bluemix.net/releases/v$SBT_VERSION/sbt-$SBT_VERSION.tgz -O - | gunzip | tar x
# prepare sbt launcher and pre-compile compiler bridge
RUN touch Main.scala && sbt ++$SCALA_VERSION compile && rm -rf target Main.scala

# docker, docker-compose
RUN apk add --no-cache docker python py2-pip
RUN pip install docker-compose awscli

RUN apk add --no-cache ncurses git openssh-client yarn

# RUN yarn global add node-gyp@3.8.0

# PhantomJS
RUN wget https://github.com/fgrehm/docker-phantomjs2/releases/download/v2.0.0-20150722/dockerized-phantomjs.tar.gz -O - | tar xz -C /

