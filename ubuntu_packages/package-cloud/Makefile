NAME         := package-cloud
VERSION      = 0.3.05
ITERATION    := $(shell facter lsbdistcodename)2
DEPENDS      := "ruby2.5" "bundler"
BUILDDEPENDS := "ruby2.5" "bundler"

PACKAGE_URL := https://packagecloud.io
PACKAGE_DESCRIPTION  := package cloud command line

include ../include/base.mk

SHELL := /bin/bash

INSTALL_DIR := /opt/$(NAME)
CHROOT_COMMAND := "set -o pipefail; \
                  cd $(INSTALL_DIR) && bundle install --binstubs --path vendor/bundle --no-cache"

include ../include/overlay_chroot.mk

build:
	mkdir -p '$(SDESTDIR)'{/usr/bin,/opt/$(NAME)}
	echo 'source "https://rubygems.org"' > '$(SDESTDIR)'$(INSTALL_DIR)/Gemfile
	echo 'gem "package_cloud", "= $(VERSION)"' >> '$(SDESTDIR)'$(INSTALL_DIR)/Gemfile
	$(MAKE) build_on_overlay
	rm -rf '$(SDESTDIR)'/home
	mkdir -p '$(SDESTDIR)'/usr/bin
	printf '#!/bin/bash\n\n%s\n' '$(INSTALL_DIR)'/bin/package_cloud' "$$@"' > '$(SDESTDIR)'/usr/bin/package_cloud
	chmod +x '$(SDESTDIR)'/usr/bin/package_cloud

package: standard_package
