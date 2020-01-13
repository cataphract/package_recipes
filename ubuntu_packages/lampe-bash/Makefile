NAME         := lampe-bash
VERSION      = 1.1.10
JSON_SH_COMMIT := e05e69a0debdba68125a33ac786726cb860b2e7b
JSON_SH_URL := https://raw.githubusercontent.com/dominictarr/JSON.sh/$(JSON_SH_COMMIT)/JSON.sh
SOURCE_URL   := https://github.com/poinck/lampe/archive/$(VERSION).tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "curl" "bc" "redshift" "iputils-ping" "sed" "coreutils" "grep" 

PACKAGE_URL := https://github.com/poinck/lampe
PACKAGE_DESCRIPTION := Interactive bash-script to control your Philips Hue lights

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

SHELL := /bin/bash

FAKECHROOT_BASE=$(SDESTDIR)
FAKECHROOT_EXCLUDE_PATH=/bin:/usr:/proc:/dev:/var:/home:/etc:$(SBUILDDIR)
FAKECHROOT_CMD_SUBST=/usr/bin/x86_64-linux-gnu-gcc=/usr/bin/x86_64-linux-gnu-gcc

export FAKECHROOT_BASE
export FAKECHROOT_EXCLUDE_PATH
export FAKECHROOT_CMD_SUBST

JSON_SH_DL_FILE := $(CACHEDIR)/JSON.sh
$(JSON_SH_DL_FILE): $(CACHEDIR)/.keep
	curl $(CURL_PARAMS) -L -f -o $(JSON_SH_DL_FILE) $(JSON_SH_URL)

install_json_sh: $(JSON_SH_DL_FILE)
	install -Dm755 $(JSON_SH_DL_FILE) "$(SDESTDIR)/usr/bin/JSON.sh"

build: install_json_sh
	install -d -m 755 $(SDESTDIR)/usr/bin
	install -m 755 $(SBUILDDIR)/lampe "$(SDESTDIR)/usr/bin/"

package: standard_package
