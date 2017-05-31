NAME         := ios-webkit-debug-proxy
_COMMIT      := 67cd34c
VERSION      = 1.71.$(_COMMIT)
ITERATION_D  := 3
SOURCE_URL   := https://github.com/google/ios-webkit-debug-proxy/archive/$(_COMMIT).tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
BUILDDEPENDS := autoconf automake libusb-dev libusb-1.0-0-dev libimobiledevice-dev \
	            libplist-dev libplist++-dev usbmuxd libtool apt-transport-https
# we can compile against an old version of libimobiledevice, but most use a newer one
DEPENDS      := "libusb-1.0-0" "libplist3" "libplist++3v5" "usbmuxd" "libimobiledevice6 (>= 1.2.1)"

PACKAGE_URL := https://github.com/google/ios-webkit-debug-proxy
PACKAGE_DESCRIPTION := A DevTools proxy (Chrome Remote Debugging Protocol) for iOS devices (Safari Remote Web Inspector).

include ../include/base.mk

fetch: $(DEB_FILE_PATH) standard_fetch

extract: standard_extract

GPG_KEY_URL := https://packagecloud.io/cataphract/misc/gpgkey
build:
	cd $(SBUILDDIR) && ./autogen.sh --prefix=/usr
	$(MAKE) -C $(SBUILDDIR) -j4 install DESTDIR='$(SDESTDIR)'

package: standard_package
