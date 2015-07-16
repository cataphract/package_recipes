NAME          := ssmtp
VERSION       := 2.64
SOURCE_URL    := http://ftp.debian.org/debian/pool/main/s/ssmtp/$(NAME)_$(VERSION).orig.tar.bz2
FETCHED_FILE  := $(NAME)-$(VERSION).tar.gz
DEPENDS       := openssl
BUILDDEPENDS  := openssl-devel

POSTINSTALL   := postinstall
PREUNINSTALL  := preuninstall
PACKAGE_URL := http://packages.debian.org/stable/mail/ssmtp
PACKAGE_DESCRIPTION := Extremely simple MTA to get mail off the system to a mailhub

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

build:
	cd $(SBUILDDIR) && \
		./configure --prefix=/usr \
					--sysconfdir=/etc \
					--mandir=/usr/share/man \
					--enable-md5auth \
					--enable-ssl \
					--enable-inet6
	sed -i 's@GEN_CONFIG=.*@GEN_CONFIG=/bin/true@' '$(SBUILDDIR)/Makefile'
	$(MAKE) -j4 -C $(SBUILDDIR)
	$(MAKE) -C $(SBUILDDIR) install \
		prefix='$(SDESTDIR)/usr' \
		mandir='$(SDESTDIR)'/usr/share/man/man8 \
		etcdir='$(SDESTDIR)'/etc
	install -D -m644 '$(SBUILDDIR)'/ssmtp.conf.5 '$(SDESTDIR)'/usr/share/man/man5/ssmtp.conf.5

package: standard_package
