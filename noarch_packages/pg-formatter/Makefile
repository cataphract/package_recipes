NAME         := pg-formatter
VERSION      = 1.2.20140704.fe9531b
SOURCE_URL   := https://github.com/darold/pgFormatter/archive/fe9531b79.tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := perl
FPM_ARGS     := -a noarch

PACKAGE_URL := https://github.com/darold/pgFormatter
PACKAGE_DESCRIPTION := PostgreSQL SQL syntax beautifier

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

build:
	cd $(SBUILDDIR) && \
		INSTALLDIRS=vendor perl Makefile.PL
	$(MAKE) -C $(SBUILDDIR) OPTIMIZE="-O2 -g -Wall"
	$(MAKE) -C $(SBUILDDIR) install DESTDIR='$(SDESTDIR)'

package: standard_package
