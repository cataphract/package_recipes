NAME         := libimobiledevice6
_COMMIT      := 53fede0
VERSION      = 1.2.1.$(_COMMIT)
ITERATION_D  := 2
SOURCE_URL   := https://github.com/libimobiledevice/libimobiledevice/archive/$(_COMMIT).tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
CONFLICTS    := "libimobiledevice-dev"
PROVIDES     := "libimobiledevice-dev"
BUILDDEPENDS := autoconf automake libusbmuxd-dev libplist-dev \
	            libplist++-dev libtool python-dev libgcrypt-dev \
				libgnutls-dev
DEPENDS      := "libusbmuxd4" "libplist3" "libplist++3v5" "libgcrypt20" "libgnutls30"

PACKAGE_URL := http://www.libimobiledevice.org
PACKAGE_DESCRIPTION := A cross-platform protocol library to communicate with iOS devices 

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

build:
	cd $(SBUILDDIR) && ./autogen.sh --prefix=/usr --disable-openssl
	$(MAKE) -C $(SBUILDDIR) -j4 install DESTDIR='$(SDESTDIR)'

package: standard_package
