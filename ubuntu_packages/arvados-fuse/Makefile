NAME         := arvados-fuse
VERSION      = 0.1.20160426220707
ITERATION_D  := 3
SOURCE_URL   := https://pypi.python.org/packages/23/1f/645c49ba320dc975e292b8a75c5fd2c52d62d41269aa57ebfa81f5b6bd20/arvados_fuse-0.1.20160426220707.tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "python" "libfuse2" "libattr1" "libcurl3" "libssl1.0.0"
_PYTHON_VERSION := 2.7
_VIRTUALENV_PKG := python-virtualenv
#_VIRTUALENV_PKG := python$(_PYTHON_VERSION)-venv
_VIRTUALENV_BIN := virtualenv
#_VIRTUALENV_BIN := /usr/bin/pyvenv-$(_PYTHON_VERSION)
BUILDDEPENDS := "gcc" "python$(_PYTHON_VERSION)-dev" "pkg-config" "libfuse-dev" "libattr1-dev" \
                "$(_VIRTUALENV_PKG)" "fakechroot" "libcurl4-openssl-dev" "libssl-dev"

PACKAGE_URL := https://pypi.python.org/pypi/arvados_fuse
PACKAGE_DESCRIPTION := This package provides a FUSE driver for Keep, \
                       the Arvados storage system. It allows you to read data \
                       from your collections as if they were on the local filesystem.

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

build:
	mkdir -p '$(SBUILDDIR)'
	fakechroot bash -e -c \
		'$(_VIRTUALENV_BIN) "/opt/$(NAME)/venv" && \
		source "/opt/$(NAME)/venv/bin/activate" && \
		cd "$(SBUILDDIR)" && \
		pip install -U pip wheel setuptools && \
		python setup.py install --optimize=2'
	mkdir -p '$(SDESTDIR)'/usr/bin
	ln -s /opt/$(NAME)/venv/bin/arv-mount '$(SDESTDIR)'/usr/bin/arv-mount

package: standard_package
