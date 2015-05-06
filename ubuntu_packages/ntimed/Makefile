NAME         := ntimed
VERSION      = 0.1-20150116
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
	mkdir -p '$(SDESTDIR)'{/usr/bin,/etc/default,/etc/init}
	cp '$(SBUILDDIR)'/ntimed-client '$(SDESTDIR)'/usr/bin
	echo 'SERVERS="0.europe.pool.ntp.org 1.europe.pool.ntp.org \
		2.europe.pool.ntp.org 3.europe.pool.ntp.org"' \
		> '$(SDESTDIR)'/etc/default/ntimed
	cp ntimed.conf '$(SDESTDIR)'/etc/init

FPM_ARGS += --config-files /etc/default/ntimed

package: standard_package
