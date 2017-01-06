NAME         := giflossy
_COMMIT      := b996bb8
VERSION      = 1.88.$(_COMMIT)
ITERATION_D  := 1
SOURCE_URL   := https://github.com/pornel/giflossy/archive/$(_COMMIT).tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
CONFLICTS    := gifsicle
BUILDDEPENDS := autoconf

PACKAGE_URL := https://kornel.ski/lossygif
PACKAGE_DESCRIPTION := Lossy GIF compressor

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

build:
	cd $(SBUILDDIR) && sh bootstrap.sh && sh configure --prefix=/usr --disable-gifview
	$(MAKE) -C $(SBUILDDIR) -j4 install DESTDIR='$(SDESTDIR)'

package: standard_package
