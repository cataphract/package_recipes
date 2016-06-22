NAME         := rubygem2.1-passenger4-apache
VERSION      := 4.0.57
ITERATION    := $(shell facter lsbdistcodename)6
DEPENDS      := "ruby2.1" "libcurl3" "apache2-mpm-worker"
BUILDDEPENDS := "ruby2.1" "libaprutil1-dev" "libapr1-dev" "apache2-threaded-dev" "libcurl4-openssl-dev" "apache2-mpm-worker"
CONFLICTS    := "libapache2-mod-passenger"

PACKAGE_URL := https://www.phusionpassenger.com/
PACKAGE_DESCRIPTION := Build, deploy, manage and scale web apps with Passenger and its world-class documentation.

POSTINSTALL  := postinst
PREUNINSTALL := prerm

include ../include/base.mk

SHELL := /bin/bash

CHROOT_COMMAND := "set -o pipefail; mkdir -p /var/lock/apache2 && \
                  export LD_LIBRARY_PATH=/opt/ruby2.1/lib && \
                  /opt/ruby2.1/bin/gem install --no-ri --no-rdoc rack -v '1.6.4' && \
                  /opt/ruby2.1/bin/gem install --no-ri --no-rdoc passenger -v '$(VERSION)' && \
                  { /opt/ruby2.1/bin/passenger-install-apache2-module --languages ruby --auto || exit 1; }; \
                  mkdir -p /etc/apache2/mods-available && \
                  { /opt/ruby2.1/bin/passenger-install-apache2-module --snippet | head -1 > /etc/apache2/mods-available/passenger.load; } && \
                  { /opt/ruby2.1/bin/passenger-install-apache2-module --snippet | sed 1d > /etc/apache2/mods-available/passenger.conf; } && \
                  find /opt/ruby2.1/lib/ruby/gems/2.1.0/gems/passenger-4.0.57/buildout/apache2/ -name '*.o' -delete && \
                  rmdir /var/lock/apache2"

include ../include/overlay_chroot.mk

MODS_AVAIL := $(SDESTDIR)/etc/apache2/mods-available
build:
	$(MAKE) build_on_overlay

package: standard_package
