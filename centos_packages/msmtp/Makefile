NAME          := msmtp
VERSION       := 1.6.1
ITERATION     := 4
SOURCE_URL    := http://download.sourceforge.net/sourceforge/msmtp/$(NAME)-$(VERSION).tar.xz
FETCHED_FILE  := $(NAME)-$(VERSION).tar.xz
TARGET_FORMAT := rpm
DEPENDS       := gnutls
BUILDDEPENDS  := gnutls-devel texinfo
POSTINSTALL   := postinstall
PREUNINSTALL  := preuninstall

PACKAGE_URL := http://msmtp.sourceforge.net/
PACKAGE_DESCRIPTION := msmtp is an SMTP client

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

SHELL := /bin/bash
# CentOs doesn't have GNU SASL in the repositories (EPEL only)
build:
	cd $(SBUILDDIR) && \
		./configure --prefix=/usr --without-libgsasl \
			--sysconfdir=/etc --with-ssl=gnutls
	$(MAKE) -j4 -C $(SBUILDDIR)
	$(MAKE) -C $(SBUILDDIR) install DESTDIR='$(SDESTDIR)'
	$(MAKE) -C $(SBUILDDIR)/doc install-html DESTDIR='$(SDESTDIR)'
	install -d '$(SDESTDIR)/usr/share/doc/msmtp'
	cd '$(SBUILDDIR)' && cp -r scripts/{find_alias,msmtpqueue,msmtpq,set_sendmail} '$(SDESTDIR)'/usr/share/doc/msmtp/
	cd '$(SBUILDDIR)' && install -D -m644 doc/*.example '$(SDESTDIR)'/usr/share/doc/msmtp/
	cd '$(SBUILDDIR)' && install -D -m644 scripts/vim/msmtp.vim "$(SDESTDIR)/usr/share/vim/vimfiles/syntax/msmtp.vim"
	rm '$(SDESTDIR)/usr/share/info/dir'

package: standard_package
