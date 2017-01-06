NAME         := s3cmd
_COMMIT      := 1556cae
VERSION      = 1.6.2-$(_COMMIT)
ITERATION    := 1
GIT_URL   := https://github.com/s3tools/s3cmd.git
BUILDDEPENDS := "git" "python-virtualenv" "fakechroot" "python-dev" \
		"libssl-dev"

PACKAGE_URL := http://s3tools.org/s3cmd
PACKAGE_DESCRIPTION := Command line tool for managing Amazon S3 and CloudFront services

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
		pip install git+$(GIT_URL)#$(_COMMIT) && \
		pip uninstall -y pip wheel'
	mkdir -p '$(SDESTDIR)'/usr/bin
	ln -s /opt/$(NAME)/venv/bin/s3cmd '$(SDESTDIR)'/usr/bin

package: standard_package
