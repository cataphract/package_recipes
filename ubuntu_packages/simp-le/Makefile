NAME         := simp-le
VERSION      = 20151207.ac836bc
_COMMIT      := ac836bc0af988cb14dc0a83dc2039e7fa541b677
ITERATION_D  := 1
SOURCE_URL   := https://github.com/kuba/simp_le/archive/$(_COMMIT).tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
BUILDDEPENDS := "git" "python-virtualenv" "fakechroot" "python-dev" \
	            "libssl-dev" "libffi-dev" "gcc" "ca-certificates"

PACKAGE_URL := https://github.com/kuba/simp_le
PACKAGE_DESCRIPTION := Simple Let\'s Encrypt Client

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
	fakechroot bash -e -c \
		'virtualenv "/opt/$(NAME)/venv" && \
		source "/opt/$(NAME)/venv/bin/activate" && \
		cd "$(SBUILDDIR)" && \
		pip install -U pip wheel setuptools && \
		python setup.py install --optimize=1'

package: standard_package
