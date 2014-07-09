NAME         := riofs
VERSION      = 0.6-33-g53d7633
SOURCE_URL   := https://github.com/skoobe/riofs/archive/53d76332e.tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "fuse" "libglib2.0-0" "libevent-2.0-5" "libxml2" "libssl1.0.0"
BUILDDEPENDS := libfuse-dev libglib2.0-dev libevent-dev libxml2-dev libssl-dev \
				autoconf

PACKAGE_URL := https://github.com/skoobe/riofs
PACKAGE_DESCRIPTION := Userspace S3 filesystem

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

build:
	cd $(SBUILDDIR) && ./autogen.sh && \
		CFLAGS="-O2 -g" ./configure --prefix=/usr
	$(MAKE) -C $(SBUILDDIR)
	$(MAKE) -C $(SBUILDDIR) install DESTDIR='$(SDESTDIR)'

package: standard_package
