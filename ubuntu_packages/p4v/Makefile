NAME         := p4v
VERSION      := 19.1
ITERATION    := 1
SOURCE_URL   := https://cdist2.perforce.com/perforce/r$(VERSION)/bin.linux26x86_64/$(NAME).tgz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "libxcb1"

PACKAGE_URL := http://www.perforce.com
PACKAGE_DESCRIPTION := Perforce Visual Client

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

SHELL := /bin/bash
build:
	mkdir -p $(SDESTDIR)/{usr/share/p4v,usr/bin,usr/share/p4v}
	cd $(SBUILDDIR) && cp -R * $(SDESTDIR)/usr/share/p4v
	ln -s /usr/share/p4v/bin/{p4v,p4merge,p4admin,p4vc} "${SDESTDIR}"/usr/bin
	mkdir -p "$(SDESTDIR)"/usr/share/icons/
	cd $(SBUILDDIR) && \
		install -Dm644 lib/P4VResources/icons/p4admin.svg "$(SDESTDIR)"/usr/share/icons/p4admin.svg && \
		install -Dm644 lib/P4VResources/icons/p4merge.svg "$(SDESTDIR)"/usr/share/icons/p4merge.svg && \
		install -Dm644 lib/P4VResources/icons/p4v.svg "$(SDESTDIR)"/usr/share/icons/p4v.svg && \
	mkdir -p "${SDESTDIR}"/usr/share/applications
	install -m644 {p4v,p4merge,p4admin}.desktop "$(SDESTDIR)"/usr/share/applications

package: standard_package
