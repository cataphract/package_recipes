NAME         := valgrind
EPOCH        := 1
_VERSION     := 3.16.1
VERSION      := $(EPOCH):$(_VERSION)
ITERATION    := 1
SOURCE_URL   := https://sourceware.org/pub/valgrind/valgrind-$(_VERSION).tar.bz2
FETCHED_FILE := $(NAME)-$(_VERSION).tar.bz2
DEPENDS      := libc6-dbg
BUILDDEPENDS := gdb gcc

PACKAGE_URL := https://www.valgrind.org/
PACKAGE_DESCRIPTION := Valgrind is an instrumentation framework for building dynamic analysis tools.

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

SHELL := /bin/bash

build:
	cd '$(SBUILDDIR)' && \
		./configure --prefix=/usr
	$(MAKE) -C '$(SBUILDDIR)' -j
	$(MAKE) -C '$(SBUILDDIR)' install DESTDIR='$(SDESTDIR)'
	rm -rf '$(SDESTDIR)'/usr/include
	rm -rf '$(SDESTDIR)'/usr/lib/valgrind/*.a
	rm -rf '$(SDESTDIR)'/usr/share/doc

package: standard_package
