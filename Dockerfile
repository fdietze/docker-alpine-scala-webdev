FROM openjdk:8-jre-alpine

ENV DEPS /deps
ENV PATH $PATH:$DEPS/sbt/bin
ENV SBT_VERSION 1.2.1
ENV SCALA_VERSION 2.12.6

# sbt
RUN apk add --no-cache bash
RUN mkdir -p $DEPS
RUN cd $DEPS && wget https://sbt-downloads.cdnedge.bluemix.net/releases/v$SBT_VERSION/sbt-$SBT_VERSION.tgz -O - | gunzip | tar x
# prepare sbt launcher and pre-compile compiler bridge
RUN touch Main.scala && sbt ++$SCALA_VERSION compile && rm -rf target Main.scala

# docker, docker-compose
RUN apk add --no-cache docker python py2-pip
RUN pip install docker-compose

RUN apk add --no-cache ncurses git openssh-client make g++ yarn
