FROM debian:jessie
MAINTAINER Alexander Trost <galexrt@googlemail.com>

ENV LD_LIBRARY_PATH="/data" ARCH="linux_amd64" JQ_ARCH="linux64"

RUN apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive apt-get -q install -y wget ca-certificates bzip2 && \
    wget -q -O /usr/bin/jq "https://github.com/stedolan/jq/releases/download/jq-1.5/jq-$JQ_ARCH" && \
    chmod +x /usr/bin/jq && \
    mkdir -p /data && \
    apt-get -qq autoremove -y --purge && \
    apt-get -qq clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD entrypoint.sh /entrypoint.sh

VOLUME ["/data"]
EXPOSE 9987/udp 10011 30033

ENTRYPOINT ["/entrypoint.sh"]
