NAME         := cloud-dns-cli
_COMMIT      := cb8bb10
VERSION      = 0.1-$(_COMMIT)
ITERATION    := 1
SOURCE_URL   := https://github.com/kuba/simp_le/archive/$(_COMMIT).tar.gz
BUILDDEPENDS := "git" "python-virtualenv" "fakechroot" "python-dev" #"libffi-dev" \
		"libssl-dev"

PACKAGE_URL := https://github.com/ephur/cloud_dns
PACKAGE_DESCRIPTION := A Tool for interacting with RackSpace Cloud DNS from the CLI

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
		'virtualenv "/opt/$(NAME)/venv" && \
		source "/opt/$(NAME)/venv/bin/activate" && \
		cd "$(SBUILDDIR)" && \
		pip install -U pip wheel setuptools "requests==2.9.1" && \
		pip install git+https://github.com/ephur/cloud_dns.git#$(_COMMIT) && \
		pip uninstall -y pip wheel'
	mkdir -p '$(SDESTDIR)'/usr/bin
	ln -s /opt/cloud-dns-cli/venv/bin/cloud_dns '$(SDESTDIR)'/usr/bin

package: standard_package
