NAME         := btrfs-progs
VERSION      := 4.1
ITERATION    := 2
SOURCE_URL   := https://github.com/kdave/btrfs-progs/archive/v$(VERSION).tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "libuuid1" "libblkid1" "liblzo2-2" "zlib1g" "e2fslibs"
BUILDDEPENDS := "uuid-dev" "libblkid-dev" "liblzo2-dev" "zlib1g-dev" "autoconf" \
	            "e2fslibs-dev" "asciidoc" "xmlto"
CONFLICTS    := "btrfs-tools"

PACKAGE_URL := https://github.com/kdave/btrfs-progs
PACKAGE_DESCRIPTION := Btrfs utility programs

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

build:
	cd '$(SBUILDDIR)' && \
		./autogen.sh && \
		./configure --prefix=/usr
	$(MAKE) -C '$(SBUILDDIR)'
	$(MAKE) -C '$(SBUILDDIR)' install DESTDIR='$(SDESTDIR)'
	install -m755 -D btrfsQuota.py '$(SDESTDIR)'/usr/sbin/btrfsQuota.py

package: standard_package
