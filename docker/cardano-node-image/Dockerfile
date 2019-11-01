FROM amazonlinux:2.0.20191016.0 AS base

RUN mkdir -p /root/
WORKDIR /root/

RUN yum update -y && \
    yum install tar gzip -y

ENV JORMUNGANDR_ARTIFACT=jormungandr-v0.7.0-rc3-x86_64-unknown-linux-gnu.tar.gz
RUN curl -LO https://github.com/input-output-hk/jormungandr/releases/download/v0.7.0-rc3/${JORMUNGANDR_ARTIFACT}

RUN tar xvzf ${JORMUNGANDR_ARTIFACT}


FROM amazonlinux:2.0.20191016.0 as runtime

RUN mkdir -p /root/
WORKDIR /root/
COPY --from=base /root/jormungandr .
COPY node-config.yaml .

CMD [ "./jormungandr", "--config", "node-config.yaml", "--genesis-block-hash", "adbdd5ede31637f6c9bad5c271eec0bc3d0cb9efb86a5b913bb55cba549d0770" ]