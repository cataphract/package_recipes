NAME         := netatalk3
VERSION      = 3.1.7.20150824-a57afbb
ITERATION    := 8
SOURCE_URL   := https://github.com/Netatalk/Netatalk/archive/a57afbbccf3e55cf2e939ad1d88c7b2b0ec8f0c5.tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "openssl" "avahi-daemon" "libcrack2" "libdb6.0" "libacl1" \
                "libgcrypt20" "libwrap0" "libdbus-glib-1-2" "python-dbus"
BUILDDEPENDS := "libssl-dev" "libavahi-client-dev" "autoconf" "automake" \
                "bison" "libtool" "pkg-config" "libcrack2-dev" "libc-dev" \
                "libdb6.0-dev" "libacl1-dev" "libgcrypt20-dev" "libwrap0-dev" \
                "libdbus-glib-1-dev"
CONFLICTS    := "netatalk"

PACKAGE_URL := https://github.com/simonvetter/afpfs-ng
PACKAGE_DESCRIPTION := Netatalk is a freely-available Open Source AFP \
fileserver. A *NIX/*BSD system running Netatalk is capable of serving many \
Macintosh clients simultaneously as an AppleShare file server (AFP).

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

CFLAGS := -DDISABLE_SHELLCHECK

build:
	cd '$(SBUILDDIR)' && \
		./bootstrap && \
		CFLAGS="$(CFLAGS)" ./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/state \
		--with-cnid-cdb-backend \
		--with-cracklib \
		--enable-pgp-uam \
		--enable-quota \
		--enable-zeroconf \
		--with-init-style=debian-sysv \
		--without-kerberos \
		--without-ldap \
		--with-acls \
		--with-cracklib \
		--with-cnid-cdb-backend \
		--with-libgcrypt \
		--enable-tcp-wrappers \
		--with-afpstats \
		--enable-pgp-uam
	$(MAKE) -C '$(SBUILDDIR)'
	$(MAKE) -C '$(SBUILDDIR)' install DESTDIR='$(SDESTDIR)'

package: standard_package
