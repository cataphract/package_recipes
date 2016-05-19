NAME         := log-courier
VERSION      := 1.8.3
ITERATION_D  := 2
SOURCE_URL   := https://github.com/driskell/log-courier/archive/v$(VERSION).tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
BUILDDEPENDS := "git"

PACKAGE_URL := https://github.com/driskell/log-courier/
PACKAGE_DESCRIPTION := Log Courier, a lightweight log shipper with Logstash integration.

POSTINSTALL := log-courier.postinst
POSTUNINSTALL := log-courier.postrm
UPSTART_FILE := $(shell pwd)/log-courier.upstart
SYSTEMD_FILE := $(shell pwd)/log-courier.service

GO_VERSION := 1.4.2

include ../include/base.mk
include ../include/go.mk

fetch: standard_fetch

extract: standard_extract

SHELL := /bin/bash

build:
	PATH=$(PATH) $(MAKE) -C '$(SBUILDDIR)'
	mkdir -p '$(SDESTDIR)'{/etc/log-courier.d/,/etc/default,/usr/bin,/var/lib/log-courier}
	install -D -m600 '$(shell pwd)'/usr.bin.log-courier '$(SDESTDIR)'/etc/apparmor.d/usr.bin.log-courier
	install -s -m755 -t '$(SDESTDIR)'/usr/bin '$(SBUILDDIR)'/bin/*
	touch '$(SDESTDIR)'/etc/default/log-courier

package: standard_package
