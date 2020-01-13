NAME         := lampe-gtk
VERSION      := 1.1.10
SOURCE_URL   := https://github.com/poinck/lampe/archive/$(VERSION).tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      :=  "curl" "libsoup2.4-1" \
				"libgtk-3-0" "lampe-bash" "libjson-glib-1.0-0"
BUILDDEPENDS := "libsoup2.4-dev" "valac" "libjson-glib-dev" "libgtk-3-dev"

PACKAGE_URL := https://github.com/poinck/lampe
PACKAGE_DESCRIPTION := GTK application and interactive bash-script to control your Philips Hue lights

include /vagrant/include/base.mk

fetch: standard_fetch

extract: standard_extract

SHELL := /bin/bash

PREFIX := /usr
build:
	cd '$(SBUILDDIR)' && \
		make -j && \
		make DESTDIR=$(SDESTDIR) install
	rm $(SDESTDIR)/usr/bin/lampe

package: standard_package
