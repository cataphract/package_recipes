NAME         := rubygem2.1-arvados-cli
VERSION      = 0.1.20160608142315
ITERATION    := $(shell facter lsbdistcodename)3
DEPENDS      := "ruby2.1" "libcurl3"
BUILDDEPENDS := "ruby2.1" "libcurl4-openssl-dev"

PACKAGE_URL := https://arvados.org/
PACKAGE_DESCRIPTION  := Arvados command line tools, with dependencies

include ../include/base.mk

SHELL := /bin/bash

CHROOT_COMMAND := "set -o pipefail; mkdir -p /var/lock/apache2 && \
                  export LD_LIBRARY_PATH=/opt/ruby2.1/lib && \
                  /opt/ruby2.1/bin/gem install --no-ri --no-rdoc arvados-cli -v '$(VERSION)'"

include ../include/overlay_chroot.mk

build:
	$(MAKE) build_on_overlay
	mkdir -p '$(SDESTDIR)'/usr/bin
	ln -s /opt/ruby2.1/bin/{arv,arv-run-pipeline-instance,arv-crunch-job,arv-tag} '$(SDESTDIR)'/usr/bin

package: standard_package
