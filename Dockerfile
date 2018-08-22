FROM openjdk:8-jre-alpine

ENV DEPS /deps
ENV PATH $PATH:$DEPS/sbt/bin
ENV SBT_VERSION 1.2.1
ENV SCALA_VERSION 2.12.6
# python2, make and g++ are only used to build node-zopfli...
RUN apk add --no-cache bash git yarn docker python py2-pip make g++
RUN mkdir -p $DEPS
RUN cd $DEPS && wget https://sbt-downloads.cdnedge.bluemix.net/releases/v$SBT_VERSION/sbt-$SBT_VERSION.tgz -O - | gunzip | tar x
# prepare sbt launcher and pre-compile compiler bridge
RUN touch Main.scala && sbt ++$SCALA_VERSION compile && rm -rf target Main.scala
RUN pip install docker-compose
