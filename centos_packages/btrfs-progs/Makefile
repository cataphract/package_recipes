NAME         := btrfs-progs
VERSION      := 4.1
ITERATION    := 2
SOURCE_URL   := https://github.com/kdave/btrfs-progs/archive/v$(VERSION).tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "libuuid" "libblkid" "lzo" "zlib" "e2fsprogs-libs" "libcom_err"
BUILDDEPENDS := "libuuid-dev" "libblkid-devel" "lzo-devel" "zlib-devel" \
	            "autoconf" "e2fsprogs-devel" "asciidoc" "xmlto" "clang"

PACKAGE_URL := https://github.com/kdave/btrfs-progs
PACKAGE_DESCRIPTION := Btrfs utility programs

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

# gcc is too old
build:
	cd '$(SBUILDDIR)' && \
		./autogen.sh && \
		CC=clang ./configure --prefix=/usr
	$(MAKE) -C '$(SBUILDDIR)'
	$(MAKE) -C '$(SBUILDDIR)' install DESTDIR='$(SDESTDIR)'

package: standard_package
