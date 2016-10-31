NAME         := p4v
VERSION      := 2015.2.1455432
ITERATION    := 1
SOURCE_URL   := http://www.perforce.com/downloads/perforce/r15.2/bin.linux26x86_64/${NAME}.tgz
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
	mkdir -p "$(SDESTDIR)"/usr/share/icons/hicolor/{16x16,24x24,48x48,96x96}/apps
	cd $(SBUILDDIR) && \
		install -Dm644 lib/p4v/P4VResources/icons/P4-Admin_16x16.png "$(SDESTDIR)"/usr/share/icons/hicolor/16x16/apps/p4admin.png && \
		install -Dm644 lib/p4v/P4VResources/icons/P4-Admin_24x24.png "$(SDESTDIR)"/usr/share/icons/hicolor/24x24/apps/p4admin.png && \
		install -Dm644 lib/p4v/P4VResources/icons/P4-Admin_48x48.png "$(SDESTDIR)"/usr/share/icons/hicolor/48x48/apps/p4admin.png && \
		install -Dm644 lib/p4v/P4VResources/icons/P4-Admin_96x96.png "$(SDESTDIR)"/usr/share/icons/hicolor/96x96/apps/p4admin.png && \
		install -Dm644 lib/p4v/P4VResources/icons/P4-Merge_16x16.png "$(SDESTDIR)"/usr/share/icons/hicolor/16x16/apps/p4merge.png && \
		install -Dm644 lib/p4v/P4VResources/icons/P4-Merge_24x24.png "$(SDESTDIR)"/usr/share/icons/hicolor/24x24/apps/p4merge.png && \
		install -Dm644 lib/p4v/P4VResources/icons/P4-Merge_48x48.png "$(SDESTDIR)"/usr/share/icons/hicolor/48x48/apps/p4merge.png && \
		install -Dm644 lib/p4v/P4VResources/icons/P4-Merge_96x96.png "$(SDESTDIR)"/usr/share/icons/hicolor/96x96/apps/p4merge.png && \
		install -Dm644 lib/p4v/P4VResources/icons/P4-V_16x16.png "$(SDESTDIR)"/usr/share/icons/hicolor/16x16/apps/p4v.png && \
		install -Dm644 lib/p4v/P4VResources/icons/P4-V_24x24.png "$(SDESTDIR)"/usr/share/icons/hicolor/24x24/apps/p4v.png && \
		install -Dm644 lib/p4v/P4VResources/icons/P4-V_48x48.png "$(SDESTDIR)"/usr/share/icons/hicolor/48x48/apps/p4v.png && \
		install -Dm644 lib/p4v/P4VResources/icons/P4-V_96x96.png "$(SDESTDIR)"/usr/share/icons/hicolor/96x96/apps/p4v.png
	mkdir -p "${SDESTDIR}"/usr/share/applications
	install -m644 {p4v,p4merge,p4admin}.desktop "$(SDESTDIR)"/usr/share/applications

package: standard_package
