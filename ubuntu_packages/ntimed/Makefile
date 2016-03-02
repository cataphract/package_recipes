NAME         := ntimed
VERSION      = 0.1-20150116
ITERATION_D  := 3
SOURCE_URL   := https://github.com/bsdphk/Ntimed/archive/db0abbb4c8.tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz

PACKAGE_URL := http://phk.freebsd.dk/time
PACKAGE_DESCRIPTION := Network Time Synchronization client

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

SHELL := /bin/bash

build:
	cd $(SBUILDDIR) && sh configure --prefix=/usr
	$(MAKE) -C $(SBUILDDIR)
	mkdir -p '$(SDESTDIR)'{/usr/bin,/etc/default,/lib/systemd/system}
	cp '$(SBUILDDIR)'/ntimed-client '$(SDESTDIR)'/usr/bin
	if [[ "$$SYSTEMD" -eq 1 ]]; then \
		cp $(shell pwd)/ntimed.service '$(SDESTDIR)'/lib/systemd/system/; \
	fi

ifndef SYSTEMD
FPM_ARGS += --deb-upstart $(shell pwd)/ntimed.conf
endif

package: standard_package
