NAME          := autossh
VERSION       := 1.4c
SOURCE_URL    := http://www.harding.motd.ca/autossh/autossh-1.4c.tgz
FETCHED_FILE  := $(NAME)-$(VERSION).tar.gz
DEPENDS       := openssh
TARGET_FORMAT := rpm

PACKAGE_URL := http://www.harding.motd.ca/autossh/
PACKAGE_DESCRIPTION := Automatically restart SSH sessions and tunnels

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

build:
	cd $(SBUILDDIR) && \
		./configure --prefix='$(SDESTDIR)/usr'
	$(MAKE) -j4 -C $(SBUILDDIR)
	make -C $(SBUILDDIR) install

package: standard_package
