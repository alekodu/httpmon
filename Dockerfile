FROM ubuntu:16.04
MAINTAINER Cristian Klein <cklein@cs.umu.se>

RUN apt-get -qq update \
    && DEBIAN_FRONTEND=noninteractive apt-get -qqy install \
        build-essential \
        libboost-all-dev \
        libcurl4-nss-dev \
    && rm -rf /var/lib/apt/lists/* 
COPY * /httpmon/
RUN \
    make -C /httpmon \
    && cp /httpmon/httpmon /usr/bin/httpmon \
    && rm -r /httpmon

ENTRYPOINT /usr/bin/httpmon --url $FRONTEND_ADDR --headers $HEADER --concurrency $CON --thinktime 1 --count $TOTAL_REQ --terminate-after-count