ifeq ($(PHP_ZTS),1)
ZTS_SUFFIX :=-zts
endif
VERSION_REL := $(shell echo $(PHP_VERSION) | cut -d. -f1,2)
NAME         := php-$(VERSION_REL)$(ZTS_SUFFIX)-bare-dbg
VERSION      = $(PHP_VERSION)
ITERATION_D  := 1

ifeq ($(VERSION_REL),5.3)
SOURCE_URL   := http://museum.php.net/php5/php-$(VERSION).tar.gz
else
SOURCE_URL   := https://www.php.net/distributions/php-$(VERSION).tar.gz
endif

FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      :=
BUILDDEPENDS :=

PACKAGE_URL := https://www.php.net/
PACKAGE_DESCRIPTION := Debug PHP builds with no modules

include ../include/base.mk

MAJOR_VERSION := $(shell echo $(PHP_VERSION) | cut -d. -f1)
ifeq ($(PHP_ZTS),1)
ZTS_FLAG := $(shell test $(MAJOR_VERSION) -ge 8 && echo --enable-zts || echo --enable-maintainer-zts)
endif

fetch: standard_fetch
extract: standard_extract
build:
	cd '$(SBUILDDIR)' && \
		./configure \
	    --prefix=/opt/$(NAME) \
		--disable-all \
		--enable-cli \
		--enable-debug \
		$(ZTS_FLAG)
	$(MAKE) -j -C '$(SBUILDDIR)'
	$(MAKE) -C '$(SBUILDDIR)' install INSTALL_ROOT='$(SDESTDIR)'
	rm $(SDESTDIR)/opt/$(NAME)/bin/php-cgi
	rm -f $(SDESTDIR)/opt/$(NAME)/bin/phpdbg
package: standard_package
