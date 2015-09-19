NAME         := librelp0
VERSION      = 1.2.8
ITERATION    := 1
SOURCE_URL   := http://download.rsyslog.com/librelp/librelp-1.2.8.tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "libgnutls26"
BUILDDEPENDS := "libgnutls-dev"

PACKAGE_URL := http://www.librelp.com/
PACKAGE_DESCRIPTION := A reliable logging library.

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract


build:
	cd '$(SBUILDDIR)' && \
		./configure --prefix=/usr
	$(MAKE) -C '$(SBUILDDIR)'
	$(MAKE) -C '$(SBUILDDIR)' install DESTDIR='$(SDESTDIR)'

package: standard_package
