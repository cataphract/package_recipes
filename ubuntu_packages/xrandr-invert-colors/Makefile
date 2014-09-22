NAME         := xrandr-invert-colors
VERSION      = 0.01
SOURCE_URL   := https://github.com/zoltanp/xrandr-invert-colors/archive/v0.01.tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "libxau6" "libxdmcp6" "libxcb-randr0" "libxcb1"
BUILDDEPENDS := libxcb-randr0-dev

PACKAGE_URL := https://github.com/zoltanp/xrandr-invert-colors
PACKAGE_DESCRIPTION := Simple utility that inverts colors on all screens, using XrandR.

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

build:
	$(MAKE) -C $(SBUILDDIR)
	mkdir -p $(SDESTDIR)/usr/bin
	cp $(SBUILDDIR)/xrandr-invert-colors.bin \
		$(SDESTDIR)/usr/bin/xrandr-invert-colors

package: standard_package
