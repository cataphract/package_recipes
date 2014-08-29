NAME          := php55-cli-minimal
VERSION       := 5.5.16
SOURCE_URL    := http://nl1.php.net/distributions/php-5.5.16.tar.bz2
FETCHED_FILE  := $(NAME)-$(VERSION).tar.bz2
CONFLICTS     := "php" "php-cli"
TARGET_FORMAT := rpm

PACKAGE_URL := http://php.net/
PACKAGE_DESCRIPTION := PHP is a popular general-purpose scripting language \
					   that is especially suited to web development.

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

build:
	cd $(SBUILDDIR) && \
		./configure --prefix=/usr --disable-all --disable-cgi \
			--enable-json
	$(MAKE) -j4 -C $(SBUILDDIR)
	$(MAKE) -C $(SBUILDDIR) install INSTALL_ROOT='$(SDESTDIR)'

package: standard_package
