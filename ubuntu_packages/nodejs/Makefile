NAME         := nodejs
VERSION      := 0.12.4
ITERATION    := 1
SOURCE_URL   := http://nodejs.org/dist/v$(VERSION)/node-v$(VERSION).tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "libssl1.0.0" "zlib1g"
BUILDDEPENDS := "libssl-dev" "zlib1g-dev" "g++"

# libuv and libc-ares are too old on trusty

PACKAGE_URL := https://nodejs.org/
PACKAGE_DESCRIPTION := Evented I/O for V8 javascript. Node\'s goal is to \
provide an easy way to build scalable network programs.


include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

build:
	cd $(SBUILDDIR) && \
		./configure --prefix=/usr \
		--without-ssl2 \
		--shared-zlib \
		--shared-openssl
	$(MAKE) -C $(SBUILDDIR) -j4
	$(MAKE) -C $(SBUILDDIR) install DESTDIR=$(SDESTDIR)

package: standard_package
