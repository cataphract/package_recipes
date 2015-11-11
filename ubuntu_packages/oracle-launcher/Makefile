NAME         := oracle-launcher
VERSION      = 0.1.0
ITERATION    := 10
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "nodejs" "iptables" #"docker-engine"
BUILDDEPENDS := "nodejs"

PACKAGE_URL := https://github.com/thehyve/package_recipes/tree/master/ubuntu_packages/oracle-launcher
PACKAGE_DESCRIPTION := Launches Oracle containers on requests

POSTINSTALL := oracle-launcher.postinst
POSTUNINSTALL := oracle-launcher.postrm
FPM_ARGS := --deb-upstart $(shell pwd)/oracle-launcher.upstart

include ../include/base.mk

SHELL := /bin/bash

extract:
	mkdir -p $(SBUILDDIR)
	cp $(shell pwd)/{main.js,package.json} '$(SBUILDDIR)'

build:
	cd '$(SBUILDDIR)' && npm install
	mkdir -p '$(SDESTDIR)'{/opt/oracle-launcher,/etc/oracle-launcher}
	cp -a '$(SBUILDDIR)'/. '$(SDESTDIR)'/opt/oracle-launcher
	install -D -m600 '$(shell pwd)'/config.yaml '$(SDESTDIR)'/etc/oracle-launcher/config.yaml
	install -D -m600 '$(shell pwd)'/opt.oracle-launcher.main.js '$(SDESTDIR)'/etc/apparmor.d/opt.oracle-launcher.main.js

package: standard_package
