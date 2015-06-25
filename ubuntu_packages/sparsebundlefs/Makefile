NAME         := sparsebundlefs
VERSION      := 2013.06.17-81b080cb
SOURCE_URL   := https://github.com/torarnv/sparsebundlefs/archive/81b080cbd285779867327ab8342346368dc1994a.tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "fuse"
BUILDDEPENDS := "libfuse-dev" "g++" "pkg-config"

PACKAGE_URL := https://github.com/torarnv/sparsebundlefs
PACKAGE_DESCRIPTION := FUSE filesystem for reading Mac OS sparse-bundle disk images.

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

build:
	$(MAKE) -C '$(SBUILDDIR)'
	install -D -m755 '$(SBUILDDIR)'/sparsebundlefs '$(SDESTDIR)'/usr/bin/sparsebundlefs

package: standard_package
