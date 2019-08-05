FROM alpine:3.10

ENV DEPS /deps
ENV PATH $PATH:$DEPS/sbt/bin
ENV SBT_VERSION 1.2.8
ENV SCALA_VERSION 2.12.9

# sbt
RUN apk add --no-cache bash openjdk11-jre-headless
RUN mkdir -p $DEPS
RUN cd $DEPS && wget https://sbt-downloads.cdnedge.bluemix.net/releases/v$SBT_VERSION/sbt-$SBT_VERSION.tgz -O - | gunzip | tar x
# prepare sbt launcher and pre-compile compiler bridge
RUN touch Main.scala && sbt ++$SCALA_VERSION compile && rm -rf target Main.scala

RUN apk add --no-cache docker python py2-pip

RUN apk add --no-cache ncurses git openssh-client yarn

# TODO: https://github.com/docker/compose/issues/6617
RUN apk add --no-cache gcc python2-dev musl-dev libffi-dev openssl-dev make

RUN pip install docker-compose

RUN pip install awscli

# RUN yarn global add node-gyp@3.8.0

# PhantomJS
RUN wget https://github.com/fgrehm/docker-phantomjs2/releases/download/v2.0.0-20150722/dockerized-phantomjs.tar.gz -O - | tar xz -C /

