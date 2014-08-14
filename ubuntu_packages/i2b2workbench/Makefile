NAME         := i2b2workbench
VERSION      := 1.7.2
ITERATION    := 1
SOURCE_URL   := http://files.thehyve.net/i2b2Workbench-src-1702.zip
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := java-runtime
BUILDDEPENDS := maven openjdk-7-jdk

PACKAGE_URL := https://www.i2b2.org/
PACKAGE_DESCRIPTION := A collection of client-side components that communicate with i2b2 Cells and help aggregate their functionality in the Hive

include ../include/base.mk

fetch: standard_fetch $(FETCHED_ECLIPSE_PATH)

extract:
	[ -d $(SBUILDDIR) ] || $(MAKE) standard_extract

SHELL := /bin/bash

FINAL_PKG_DIR := $(SDESTDIR)/opt/i2b2workbench
build:
	[ -f $(SBUILDDIR)/pom.xml ] || \
		patch -d $(SBUILDDIR) -p2 < i2b2Workbench-src-1702.patch
	cd $(SBUILDDIR) && mvn clean install

package:
	mkdir -p $(SDESTDIR)/opt
	cp -a $(SBUILDDIR)/edu.harvard.i2b2.eclipse/product/target/products/edu.harvard.i2b2.eclipse.product/linux/gtk/x86_64/i2b2workbench/ \
		$(SDESTDIR)/opt
	install -D -m 755 start.sh $(FINAL_PKG_DIR)/start.sh
	sed -i -e 's@endorsed_lib@/opt/i2b2workbench/endorsed_lib@' \
		$(SDESTDIR)/opt/i2b2workbench/i2b2workbench.ini
	mkdir -p $(SDESTDIR)/usr/bin
	ln -s /opt/i2b2workbench/start.sh $(SDESTDIR)/usr/bin/i2b2workbench
	install -D -m 644 i2b2Workbench.png $(SDESTDIR)/usr/share/icons/hicolor/48x48/apps/i2b2Workbench.png
	install -D -m 644 i2b2Workbench.desktop $(SDESTDIR)/usr/share/applications/i2b2Workbench.desktop
	find $(SDESTDIR) -type d -exec chmod 755 '{}' \;
	$(MAKE) standard_package
