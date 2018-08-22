FROM openjdk:8-jre-alpine

ENV DEPS /deps
ENV PATH $PATH:$DEPS/sbt/bin

RUN apk add --no-cache bash yarn
RUN mkdir -p $DEPS
RUN cd $DEPS && wget https://piccolo.link/sbt-1.2.1.tgz -O - | gunzip | tar x
RUN sbt exit && rm -rf target
