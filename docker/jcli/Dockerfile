FROM amazonlinux:2.0.20191016.0

RUN yum update -y && \
    yum install tar gzip -y

ENV JORMUNGANDR_ARTIFACT=jormungandr-v0.7.0-rc3-x86_64-unknown-linux-gnu.tar.gz
RUN curl -LO https://github.com/input-output-hk/jormungandr/releases/download/v0.7.0-rc3/${JORMUNGANDR_ARTIFACT}

RUN tar xvzf ${JORMUNGANDR_ARTIFACT}

CMD ["/bin/bash"]