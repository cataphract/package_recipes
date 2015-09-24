NAME         := log-courier
VERSION      = 1.8.1
ITERATION    := 6
SOURCE_URL   := https://github.com/driskell/log-courier/archive/v$(VERSION).tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
BUILDDEPENDS := "git"

PACKAGE_URL := https://github.com/driskell/log-courier/
PACKAGE_DESCRIPTION := Log Courier, a lightweight log shipper with Logstash integration.

POSTINSTALL := log-courier.postinst
POSTUNINSTALL := log-courier.postrm
FPM_ARGS := --deb-upstart $(shell pwd)/log-courier.upstart
GO_VERSION := 1.4.2

include ../include/base.mk
include ../include/go.mk

fetch: standard_fetch

extract: standard_extract

SHELL := /bin/bash

build: $(LIBLOGGING_LIB)
	PATH=$(PATH) $(MAKE) -C '$(SBUILDDIR)'
	mkdir -p '$(SDESTDIR)'{/etc/log-courier.d/,/usr/bin,/var/lib/log-courier}
	install -D -m600 '$(shell pwd)'/usr.bin.log-courier '$(SDESTDIR)'/etc/apparmor.d/usr.bin.log-courier
	install -s -m755 -t '$(SDESTDIR)'/usr/bin '$(SBUILDDIR)'/bin/*

package: standard_package
