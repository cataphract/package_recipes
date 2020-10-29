NAME         := mitmproxy
VERSION      = 5.0.1
ITERATION    := 1
BUILDDEPENDS := "python3-virtualenv" "fakechroot" "python3-dev" "virtualenv"

PACKAGE_URL := https://mitmproxy.org/
PACKAGE_DESCRIPTION := mitmproxy is a free and open source interactive HTTPS proxy.

include ../include/base.mk

fetch:
extract:
	mkdir -p '$(SBUILDDIR)'

SHELL := /bin/bash

FAKECHROOT_BASE=$(SDESTDIR)
FAKECHROOT_EXCLUDE_PATH=/bin:/lib:/usr:/proc:/dev:/var:/home:/etc:$(SBUILDDIR)
FAKECHROOT_CMD_SUBST=/usr/bin/x86_64-linux-gnu-gcc=/usr/bin/x86_64-linux-gnu-gcc

export FAKECHROOT_BASE
export FAKECHROOT_EXCLUDE_PATH
export FAKECHROOT_CMD_SUBST

build:
	fakechroot bash -e -c \
		'virtualenv -p /usr/bin/python3 "/opt/$(NAME)/venv" && \
		source "/opt/$(NAME)/venv/bin/activate" && \
		cd "$(SBUILDDIR)" && \
		pip install -U pip wheel setuptools && \
		pip install "mitmproxy==$(VERSION)" && \
		pip uninstall -y pip wheel'
	mkdir -p '$(SDESTDIR)'/usr/bin
	ln -s /opt/mitmproxy/venv/bin/mitmproxy '$(SDESTDIR)'/usr/bin
	ln -s /opt/mitmproxy/venv/bin/mitmdump '$(SDESTDIR)'/usr/bin
	ln -s /opt/mitmproxy/venv/bin/mitmweb '$(SDESTDIR)'/usr/bin

package: standard_package
