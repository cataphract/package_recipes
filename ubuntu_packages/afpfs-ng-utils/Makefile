NAME         := afpfs-ng-utils
VERSION      = 0.8.2.2015.07.29-f6e24eb
SOURCE_URL   := https://github.com/simonvetter/afpfs-ng/archive/f6e24eb73c9283732c3b5d9cb101a1e2e4fade3e.tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "libgcrypt11" "libreadline6" "libfuse2"
BUILDDEPENDS := "libgcrypt11-dev" "libreadline6-dev" "libfuse-dev"

PACKAGE_URL := https://github.com/simonvetter/afpfs-ng
PACKAGE_DESCRIPTION := afpfs-ng/libafpclient is an open source client for the Apple Filing Protocol

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

build:
	cd '$(SBUILDDIR)' && \
		./configure --prefix=/usr
	$(MAKE) -C '$(SBUILDDIR)'
	$(MAKE) -C '$(SBUILDDIR)' install DESTDIR='$(SDESTDIR)'

package: standard_package
