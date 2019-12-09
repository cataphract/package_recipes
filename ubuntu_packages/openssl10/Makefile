NAME         := openssl10
VERSION      = 1.0.2t
SOURCE_URL   := https://www.openssl.org/source/openssl-$(VERSION).tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz

PACKAGE_URL := https://www.openssl.org/
PACKAGE_DESCRIPTION := OpenSSL is a robust, commercial-grade, and full-featured \
	toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols.

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

SHELL := /bin/bash

build:
	cd $(SBUILDDIR) && \
		./Configure --prefix=/usr \
		--openssldir=/etc/ssl \
		--libdir=lib/openssl-1.0 \
		shared no-ssl3-method enable-ec_nistp_64_gcc_128 \
		linux-x86_64 -Wa,--noexecstack
	$(MAKE) -C $(SBUILDDIR) -j depend
	$(MAKE) -C $(SBUILDDIR) -j
	$(MAKE) INSTALL_PREFIX="$(SDESTDIR)" -C $(SBUILDDIR) install_sw
	cd $(SBUILDDIR) && \
		install -m755 -d "$(SDESTDIR)/usr/include/openssl-1.0" && \
		mv "$(SDESTDIR)/usr/include/openssl" "$(SDESTDIR)/usr/include/openssl-1.0/" && \
		mv "$(SDESTDIR)/usr/lib/openssl-1.0/libcrypto.so.1.0.0" "$(SDESTDIR)/usr/lib/" && \
		mv "$(SDESTDIR)/usr/lib/openssl-1.0/libssl.so.1.0.0" "$(SDESTDIR)/usr/lib/" && \
		ln -sf ../libssl.so.1.0.0 "$(SDESTDIR)/usr/lib/openssl-1.0/libssl.so" && \
		ln -sf ../libcrypto.so.1.0.0 "$(SDESTDIR)/usr/lib/openssl-1.0/libcrypto.so" && \
		mv "$(SDESTDIR)/usr/bin/openssl" "$(SDESTDIR)/usr/bin/openssl-1.0" && \
		sed -e 's|/include$$|/include/openssl-1.0|' -i "$(SDESTDIR)"/usr/lib/openssl-1.0/pkgconfig/*.pc && \
		rm -rf "$(SDESTDIR)"/{etc,usr/bin/c_rehash} && \
		rm LICENSE

package: standard_package
