NAME         := ruby2.1
VERSION      = 2.1.9
ITERATION_D  := 7
SOURCE_URL   := https://cache.ruby-lang.org/pub/ruby/2.1/ruby-$(VERSION).tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "libssl1.0.0" "libyaml-0-2" "libreadline6" "zlib1g" \
                "libncurses5" "libffi6" "libgdbm3"
BUILDDEPENDS := "libssl-dev" "libyaml-dev" "libreadline6-dev" "zlib1g-dev" \
				"libncurses5-dev" "libffi-dev" "libgdbm-dev"

PACKAGE_URL := https://www.ruby-lang.org/
PACKAGE_DESCRIPTION := A dynamic, open source programming language with a focus\
                       on simplicity and productivity. It has an elegant \
					   syntax that is natural to read and easy to write.

POSTINSTALL := postinst
PREUNINSTALL := prerm
include ../include/base.mk

fetch: standard_fetch
extract: standard_extract
build:
	cd '$(SBUILDDIR)' && \
		./configure \
	    --prefix=/opt/ruby2.1 \
		--without-tcl \
		--without-tk \
		--enable-load-relative \
		--sysconfdir=/etc \
		--with-readline-dir=/usr/include/readline \
		--disable-install-doc \
		--enable-shared
	$(MAKE) -j8 -C '$(SBUILDDIR)'
	$(MAKE) -C '$(SBUILDDIR)' install DESTDIR='$(SDESTDIR)'
package: standard_package
