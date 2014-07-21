NAME         := pgtune
VERSION      = 20131227.pull8
SOURCE_URL   := https://github.com/gregs1104/pgtune/pull/8
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := python
FPM_ARGS     := -a noarch

PACKAGE_URL := http://pgfoundry.org/projects/pgtune/
PACKAGE_DESCRIPTION := pgtune takes the wimpy default postgresql.conf and \
                       expands the database server to be as powerful as the \
                       hardware it\'s being deployed on

include ../include/base.mk

CACHEDESTDIR := $(CACHEDIR)/pgtune

fetch:
	sudo apt-get install -y git
	test -d '$(CACHEDESTDIR)' || { \
		git clone https://github.com/gregs1104/pgtune.git '$(CACHEDESTDIR)' && \
		cd '$(CACHEDESTDIR)' && \
		git fetch origin refs/pull/8/head && \
		git checkout FETCH_HEAD; }

extract:
	cp -a '$(CACHEDESTDIR)/.' '$(SBUILDDIR)'
	cd '$(SBUILDDIR)' && patch -p0 < pgtune-settingsdir.patch

build:
	install -d '$(SDESTDIR)/usr/bin'
	install -d '$(SDESTDIR)/usr/share/pgtune'
	cd '$(SBUILDDIR)' && \
		install -m 755 pgtune '$(SDESTDIR)/usr/bin' && \
		install -m 644 pg_settings* '$(SDESTDIR)/usr/share/pgtune'

package: standard_package
