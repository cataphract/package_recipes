NAME         := arvados-login-sync
VERSION      = 0.1.20160203112632
ITERATION    := $(shell facter lsbdistcodename)1
DEPENDS      := "ruby2.1" "rubygem2.1-bundler"
BUILDDEPENDS := "ruby2.1" "rubygem2.1-bundler"

PACKAGE_URL := https://arvados.org/
PACKAGE_DESCRIPTION  := Creates and updates local login accounts for Arvados users.

include ../include/base.mk

SHELL := /bin/bash

INSTALL_DIR := /opt/arvados-login-sync
CHROOT_COMMAND := "set -o pipefail; \
                  export LD_LIBRARY_PATH=/opt/ruby2.1/lib && \
                  cd $(INSTALL_DIR) && /opt/ruby2.1/bin/bundle install --binstubs --path vendor/bundle --no-cache"

include ../include/overlay_chroot.mk

build:
	mkdir -p '$(SDESTDIR)'{/usr/bin,/opt/arvados-login-sync}
	echo 'source "https://rubygems.org"' > '$(SDESTDIR)'$(INSTALL_DIR)/Gemfile
	echo 'gem "arvados-login-sync", "= $(VERSION)"' >> '$(SDESTDIR)'$(INSTALL_DIR)/Gemfile
	$(MAKE) build_on_overlay
	rm -rf '$(SDESTDIR)'/home
	ln -s '$(INSTALL_DIR)'/bin/arvados-login-sync '$(SDESTDIR)'/usr/bin

package: standard_package
