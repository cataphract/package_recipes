NAME          := python2.7
VERSION       := 2.7.15
SOURCE_URL    := https://www.python.org/ftp/python/$(VERSION)/Python-$(VERSION).tgz
FETCHED_FILE  := $(NAME)-$(VERSION).tar.gz
DEPENDS       := zlib readline ncurses openssl gdbm sqlite bzip2 libffi expat
BUILDDEPENDS  := zlib-devel readline-devel ncurses-devel openssl-devel \
				 gdbm-devel sqlite-devel bzip2-devel libffi-devel expat-devel
TARGET_FORMAT := rpm

PACKAGE_URL := https://www.python.org/
PACKAGE_DESCRIPTION := Python is a programming language that lets you work \
                       quickly and integrate systems more effectively.

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

build:
	cd $(SBUILDDIR) && \
        ./configure --prefix=/usr \
          --libdir=/usr/lib64 \
          --enable-shared \
          --with-threads \
          --with-lto \
          --enable-ipv6 \
          --enable-unicode=ucs4 \
          --with-system-expat \
          --with-system-ffi \
          --with-dbmliborder=gdbm:ndbm \
          --without-ensurepip
	EXTRATESTOPTS=--list-tests $(MAKE) -j4 -C $(SBUILDDIR)
	$(MAKE) -C $(SBUILDDIR) install DESTDIR='$(SDESTDIR)'
	bash -c 'rm "$(SDESTDIR)"/usr/bin/{pydoc,python,python2}'

package: standard_package
