FROM amazonlinux:2.0.20191016.0 AS base
LABEL maintainer="wcschlosser@gmail.com"

RUN mkdir -p /root/
WORKDIR /root/

RUN yum update -y && \
    yum install tar gzip -y

ARG JORMUNGANDR_VERSION
ARG JORMUNGANDR_ARCH
ARG JORMUNGANDR_OS

ENV JORMUNGANDR_VERSION=${JORMUNGANDR_VERSION}
ENV JORMUNGANDR_ARCH=${JORMUNGANDR_ARCH}
ENV JORMUNGANDR_OS=${JORMUNGANDR_OS}

ENV JORMUNGANDR_ARTIFACT=jormungandr-$JORMUNGANDR_VERSION-$JORMUNGANDR_ARCH-unknown-$JORMUNGANDR_OS.tar.gz

RUN env
RUN curl -LO "https://github.com/input-output-hk/jormungandr/releases/download/$JORMUNGANDR_VERSION/$JORMUNGANDR_ARTIFACT"
RUN tar xvzf $JORMUNGANDR_ARTIFACT


FROM amazonlinux:2.0.20191016.0 as runtime

RUN mkdir -p /root/
WORKDIR /root/
COPY --from=base /root/jormungandr .

CMD [ "/bin/bash" ]