NAME         := repo
VERSION      := 1.21
SOURCE_URL   := http://files.thehyve.net/$(NAME)-$(VERSION)
FETCHED_FILE := $(NAME)-$(VERSION)
DEPENDS      := python
FPM_ARGS     := -a noarch

PACKAGE_URL := https://android.googlesource.com/tools/repo

include ../include/base.mk

CACHEDESTDIR := $(CACHEDIR)/pgtune

fetch: standard_fetch

build:
	install -d '$(SDESTDIR)/usr/bin'
	install -m 755 '$(FETCHED_FILE_PATH)' '$(SDESTDIR)/usr/bin/repo'

package: standard_package
