NAME          := autoconf
VERSION       := 2.68
SOURCE_URL    := https://ftp.gnu.org/pub/gnu/autoconf/$(NAME)-$(VERSION).tar.gz
FETCHED_FILE  := $(NAME)-$(VERSION).tar.gz

PACKAGE_URL := https://www.gnu.org/software/autoconf/
PACKAGE_DESCRIPTION := Autoconf is an extensible package of M4 macros that produce shell scripts to automatically configure software source code packages.

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

build:
	cd $(SBUILDDIR) && \
		./configure --prefix=/usr
	$(MAKE) -j4 -C $(SBUILDDIR)
	$(MAKE) -C $(SBUILDDIR) install DESTDIR='$(SDESTDIR)'
	rm $(SDESTDIR)/usr/share/info/dir

package: standard_package
