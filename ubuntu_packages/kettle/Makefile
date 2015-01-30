NAME         := kettle
VERSION      := 5.2.0.0
_dl_dir      := 5.2
_dl_suffix   := 209
ITERATION    := 5
SOURCE_URL   := http://downloads.sourceforge.net/project/pentaho/Data\%20Integration/$(_dl_dir)/pdi-ce-$(VERSION)-$(_dl_suffix).zip
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "java7-runtime"
BUILDDEPENDS := "zip"

PACKAGE_URL := http://kettle.pentaho.com/
PACKAGE_DESCRIPTION := Pentaho Data Integration Community Edition (Kettle) is an ETL tool

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

F := \#!/bin/bash\n\n/usr/share/data-integration/%s.sh "$$@"\n
export F
TARGET_DIR := $(SDESTDIR)/usr/share/data-integration
SHELL := /bin/bash
EXTRA_TMP := $(shell mktemp -d '$(BUILDDIR)/kettle_XXXX')
build:
	cd '$(SBUILDDIR)' && \
		rm -rf "Data Integration.app" && \
		rm *.bat && \
		rm README_{OSX,UNIX_AS400,INFOBRIGHT}.txt && \
		rm -r libswt/{osx64,win32,win64} && \
		rm -r libswt/linux/x86 && \
		rm -r plugins/pentaho-big-data-plugin
	cd '$(EXTRA_TMP)' && \
		printf "$$F" kitchen > kitchen.sh && \
		install -D -m755 kitchen.sh $(SDESTDIR)/usr/bin/kitchen.sh && \
		printf "$$F" pan > pan.sh && \
		install -D -m755 pan.sh     $(SDESTDIR)/usr/bin/pan.sh && \
		printf "$$F" carte > carte.sh && \
		install -D -m755 carte.sh   $(SDESTDIR)/usr/bin/carte.sh && \
		printf "$$F" import > import.sh && \
		install -D -m755 import.sh  $(SDESTDIR)/usr/bin/import.sh && \
		echo -e '#!/bin/bash\n\ncd /usr/share/data-integration\n./spoon.sh "$$@"\n' > spoon.sh && \
		install -D -m755 spoon.sh   $(SDESTDIR)/usr/bin/spoon.sh && \
		install -D -m644 "$$OLDPWD"/spoon.desktop $(SDESTDIR)/usr/share/applications/spoon.desktop && \
		rm -r '$(EXTRA_TMP)'
	cd '$(SBUILDDIR)' && \
		mkdir -p org/pentaho/di/core/market && \
		cp "$$OLDPWD"/Market.class org/pentaho/di/core/market && \
		zip plugins/market/market-$(VERSION)-$(_dl_suffix).jar \
			org/pentaho/di/core/market/Market.class && \
		rm -r org/pentaho/di/core/market
	mkdir -p '$(TARGET_DIR)'
	cp -r '$(SBUILDDIR)'/. '$(TARGET_DIR)'

package: standard_package
