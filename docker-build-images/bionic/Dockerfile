FROM ubuntu:bionic
MAINTAINER Gustavo Lopes <mail@geleia.net>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q && \
	apt-get install -y --no-install-recommends apt-transport-https gnupg && \
	rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 8E49386A569C9ACA01793873D142B1E898B37168 && \
	#echo deb https://packagecloud.io/cataphract/misc/ubuntu/ bionic main > /etc/apt/sources.list.d/internal.list && \
    apt-get update -q && \
    apt-get install -y --no-install-recommends \
        ruby-dev bsdtar sudo \
        make gcc g++ pkg-config binutils \
        git curl wget \
        facter lsb-release && \
    rm -rf /var/lib/apt/lists/* && \
    gem install --no-ri --no-rdoc -v 1.11.0 fpm && \
    echo 'user   ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    curl -L -f -o /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.9/gosu-$(dpkg --print-architecture)" && \
    chmod +x /usr/local/bin/gosu

ADD https://github.com/Yelp/dumb-init/releases/download/v1.1.0/dumb-init_1.1.0_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init
ADD entrypoint /
ENTRYPOINT [ "dumb-init", "/entrypoint" ]
