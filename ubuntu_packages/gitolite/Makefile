NAME         := gitolite3
VERSION      = 3.6.5
ITERATION_D  := 4
SOURCE_URL   := https://github.com/sitaramc/gitolite/archive/v$(VERSION).tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "git" "openssh-client" "openssh-server"

PACKAGE_URL := https://github.com/sitaramc/gitolite
PACKAGE_DESCRIPTION := An access control layer on top of git

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

SHELL := /bin/bash

build:
	install -d '$(SDESTDIR)'/usr/{bin,lib/gitolite}
	cp -a '$(SBUILDDIR)'/src/* '$(SDESTDIR)'/usr/lib/gitolite
	ln -s /usr/lib/gitolite/gitolite '$(SDESTDIR)'/usr/bin/gitolite

package: standard_package
