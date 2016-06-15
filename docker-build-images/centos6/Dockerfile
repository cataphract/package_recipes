FROM centos:6
MAINTAINER Gustavo Lopes <gustavo@thehyve.nl>

RUN yum -y --nogpgcheck localinstall \
	https://repo.thehyve.nl/service/local/repositories/releases/content/org/libarchive/bsdtar/3.1.2/bsdtar-3.1.2-rpm.rpm
RUN yum install --nogpgcheck -y sudo git gcc-c++ rpm-build curl wget pkgconfig gcc
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
	{ \curl -sSL https://get.rvm.io | bash -s stable; } && \
	bash -l -c 'rvm install 2.1 && rvm use 2.1 --default'
RUN bash -l -c 'gem install --no-ri --no-rdoc -v 1.6.1 fpm'
RUN bash -l -c 'gem install --no-ri --no-rdoc -v 2.4.6 facter'
RUN echo 'user   ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    curl -L -f -o /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64" && \
    chmod +x /usr/local/bin/gosu

ADD entrypoint /
ADD fpm_wrapper /usr/local/bin/fpm
ADD facter_wrapper /usr/local/bin/facter
ADD https://github.com/Yelp/dumb-init/releases/download/v1.1.0/dumb-init_1.1.0_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init
ENTRYPOINT [ "dumb-init", "/entrypoint" ]
