NAME         := arvados-cli
VERSION      = 0.1.20160608142315
ITERATION    := $(shell facter lsbdistcodename)1
DEPENDS      := "ruby2.1" "rubygem2.1-bundler" "libcurl3"
BUILDDEPENDS := "ruby2.1" "rubygem2.1-bundler" "libcurl4-openssl-dev"
CONFLICTS    := "rubygem2.1-$(NAME)"

PACKAGE_URL := https://arvados.org/
PACKAGE_DESCRIPTION  := Arvados command line tools

include ../include/base.mk

SHELL := /bin/bash

INSTALL_DIR := /opt/$(NAME)
CHROOT_COMMAND := "set -o pipefail; \
                  export LD_LIBRARY_PATH=/opt/ruby2.1/lib && \
                  cd $(INSTALL_DIR) && /opt/ruby2.1/bin/bundle install --binstubs --path vendor/bundle --no-cache"

include ../include/overlay_chroot.mk

build:
	mkdir -p '$(SDESTDIR)'{/usr/bin,/opt/$(NAME)}
	echo 'source "https://rubygems.org"' > '$(SDESTDIR)'$(INSTALL_DIR)/Gemfile
	echo 'gem "$(NAME)", "= $(VERSION)"' >> '$(SDESTDIR)'$(INSTALL_DIR)/Gemfile
	$(MAKE) build_on_overlay
	rm -rf '$(SDESTDIR)'/home
	ln -s '$(INSTALL_DIR)'/bin/{arv,arv-run-pipeline-instance,arv-crunch-job,arv-tag} '$(SDESTDIR)'/usr/bin

package: standard_package
