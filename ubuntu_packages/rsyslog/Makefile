NAME         := rsyslog
VERSION      = 8.12.0
ITERATION    := 2
SOURCE_URL   := http://www.rsyslog.com/files/download/rsyslog/rsyslog-$(VERSION).tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "libgnutls26" "librelp0 (>=1.2.8)" "libestr0" "libjson0" \
				"zlib1g" "libgcrypt11" "libuuid1"
BUILDDEPENDS := "libgnutls-dev" "librelp0=1.2.8-1" "bison" "libjson0-dev" \
	            "libjson0-dev" "zlib1g-dev" "libgcrypt11-dev" "libestr-dev" \
				"uuid-dev" "python-docutils"

CONFLICTS := "rsyslog-gnutls" "rsyslog-relp"
PACKAGE_URL := http://www.librelp.com/
PACKAGE_DESCRIPTION := A reliable logging library.

POSTINSTALL := rsyslog.postinst
POSTUNINSTALL := rsyslog.postrm
FPM_ARGS := --deb-init $(shell pwd)/rsyslog.init --deb-upstart $(shell pwd)/rsyslog.dmesg.upstart

include ../include/base.mk

DEPS_INSTALL_DIR := $(BUILDDIR)/rsyslog-libs
$(DEPS_INSTALL_DIR): $(BUILDDIR)/.keep
	mkdir '$@'

LIBLOGGING_VERSION := 1.0.5

LIBLOGGING_SOURCE_URL := http://download.rsyslog.com/liblogging/liblogging-$(LIBLOGGING_VERSION).tar.gz
LIBLOGGING_LIB := $(DEPS_INSTALL_DIR)/lib/liblogging-stdlog.a

LIBLOGGING_FETCHED_FILE := $(notdir $(LIBLOGGING_SOURCE_URL))
LIBLOGGING_FETCHED_FILE_PATH = $(CACHEDIR)/$(LIBLOGGING_FETCHED_FILE)
$(LIBLOGGING_FETCHED_FILE_PATH): $(CACHEDIR)/.keep
	curl $(CURL_PARAMS) -L -f -o $(LIBLOGGING_FETCHED_FILE_PATH) $(LIBLOGGING_SOURCE_URL)

LIBLOGGING_BUILDDIR := $(BUILDDIR)/liblogging
$(LIBLOGGING_BUILDDIR)/.keep: $(LIBLOGGING_FETCHED_FILE_PATH) $(BUILDDIR)/.keep
	rm -rf '$(LIBLOGGING_BUILDDIR)'
	mkdir '$(LIBLOGGING_BUILDDIR)'
	tar -C '$(LIBLOGGING_BUILDDIR)' --strip-components=1 -xf '$<'
	touch '$@'

build_liblogging: $(LIBLOGGING_LIB)
$(LIBLOGGING_LIB): $(LIBLOGGING_BUILDDIR)/.keep
	cd $(LIBLOGGING_BUILDDIR) && \
		./configure --prefix="$(DEPS_INSTALL_DIR)" \
		--enable-static \
		--disable-shared \
		--disable-journal
	$(MAKE) -C '$(LIBLOGGING_BUILDDIR)' -j8 install

fetch: standard_fetch $(LIBLOGGING_FETCHED_FILE_PATH)

extract: standard_extract $(LIBLOGGING_BUILDDIR)

build: $(LIBLOGGING_LIB)
	cd '$(SBUILDDIR)' && \
		CFLAGS=-I$(DEPS_INSTALL_DIR)/include \
		LFLAGS=-L$(DEPS_INSTALL_DIR)/lib \
		PKG_CONFIG_PATH=$(DEPS_INSTALL_DIR)/lib/pkgconfig ./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--enable-kmsg \
		--enable-usertools \
		--enable-gnutls \
		--enable-libgcrypt \
		--enable-relp \
		--enable-imfile \
		--enable-imptcp \
		--enable-omstdout \
		--enable-omruleset \
		--enable-omuxsock \
		--enable-generate-man-pages \
		--enable-liblogging-stdlog

	$(MAKE) -C '$(SBUILDDIR)'
	$(MAKE) -C '$(SBUILDDIR)' install DESTDIR='$(SDESTDIR)'
	find '$(SDESTDIR)' -name '*.la' -delete
	install -D -m644 rsyslog.conf $(SDESTDIR)/etc/rsyslog.conf
	install -D -m644 50-default.conf $(SDESTDIR)/usr/share/rsyslog/50-default.conf

package: standard_package

clean: clean_extra
clean_extra:
	rm -rf '$(LIBLOGGING_BUILDDIR)' '$(DEPS_INSTALL_DIR)'
