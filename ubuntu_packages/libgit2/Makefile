NAME         := libgit2
VERSION      := 0.27.7
SOURCE_URL   := https://github.com/libgit2/libgit2/archive/v$(VERSION).tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "libssl1.0.0"
BUILDDEPENDS := "libssl-dev" "python" "cmake"

PACKAGE_URL := https://libgit2.org/
PACKAGE_DESCRIPTION := libgit2 is a portable, pure C implementation of the Git \
core methods provided as a re-entrant linkable library with a solid API, \
allowing you to write native speed custom Git applications in any language \
which supports C bindings.

include /vagrant/include/base.mk

fetch: standard_fetch

extract: standard_extract

SHELL := /bin/bash

PREFIX := /usr
build:
	cd '$(SBUILDDIR)' && \
		cmake -DCMAKE_INSTALL_PREFIX=$(PREFIX) && \
		DESTDIR=$(SDESTDIR) cmake --build . --target install

package: standard_package
