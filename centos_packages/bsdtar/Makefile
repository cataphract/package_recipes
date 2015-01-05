NAME          := bsdtar
VERSION       := 3.1.2
SOURCE_URL    := http://www.libarchive.org/downloads/libarchive-$(VERSION).tar.gz
FETCHED_FILE  := $(NAME)-$(VERSION).tar.bz2
TARGET_FORMAT := rpm
DEPENDS       := zlib openssl bzip2 lzo xz-libs
BUILDDEPENDS  := zlib-devel openssl-devel bzip2-devel lzo-devel xz-devel

PACKAGE_URL := http://www.libarchive.org/
PACKAGE_DESCRIPTION := Multi-format archive and compression library

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

build:
	cd $(SBUILDDIR) && \
		./configure --prefix=/usr --enable-bsdtar=static --disable-shared \
			--disable-bsdcpio
	$(MAKE) -j4 -C $(SBUILDDIR)
	$(MAKE) -C $(SBUILDDIR) install DESTDIR='$(SDESTDIR)'
	rm -rf '$(SDESTDIR)'/usr/{share/man/man3,lib,include}

package: standard_package
