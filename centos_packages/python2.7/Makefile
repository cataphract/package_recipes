NAME          := python2.7
VERSION       := 2.7.8
SOURCE_URL    := https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tgz
FETCHED_FILE  := $(NAME)-$(VERSION).tar.gz
DEPENDS       := zlib readline ncurses openssl gdbm sqlite bzip2
BUILDDEPENDS  := zlib-devel readline-devel ncurses-devel openssl-devel \
				 gdbm-devel sqlite-devel bzip2-devel
TARGET_FORMAT := rpm

PACKAGE_URL := https://www.python.org/
PACKAGE_DESCRIPTION := Python is a programming language that lets you work \
                       quickly and integrate systems more effectively.

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

build:
	cd $(SBUILDDIR) && \
		./configure --prefix=/usr --enable-ipv6 \
			--enable-unicode=ucs4 --with-dbmliborder=bdb:gdbm
	$(MAKE) -j4 -C $(SBUILDDIR)
	$(MAKE) -C $(SBUILDDIR) install DESTDIR='$(SDESTDIR)'
	bash -c 'rm "$(SDESTDIR)"/usr/bin/{pydoc,python,python2}'

package: standard_package
