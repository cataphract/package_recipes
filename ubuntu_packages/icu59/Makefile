NAME         := icu59
VERSION      = 59.2
SOURCE_URL   := https://github.com/unicode-org/icu/releases/download/release-59-2/icu4c-59_2-src.tgz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
PACKAGE_URL := http://www.icu-project.org/
PACKAGE_DESCRIPTION := International Components for Unicode library

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

SHELL := /bin/bash

build:
	cd $(SBUILDDIR)/source && \
		./configure --prefix=/opt/icu59
	sed -i 's/xlocale/locale/' $(SBUILDDIR)/source/i18n/digitlst.cpp
	$(MAKE) -C $(SBUILDDIR)/source -j
	$(MAKE) -C $(SBUILDDIR)/source DESTDIR=$(SDESTDIR) install
	find $(SDESTDIR)/opt/icu59 -name '*.so.59' -or -name '*.so.59.2' -exec ln -s $(SDESTDIR)'{}' /usr/lib \;

package: standard_package
