NAME         := cmake
VERSION      := 3.15.4
ITERATION    := 1
SOURCE_URL   := https://github.com/Kitware/CMake/releases/download/v$(VERSION)/$(NAME)-$(VERSION)-Linux-x86_64.tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz

PACKAGE_URL := https://cmake.org
PACKAGE_DESCRIPTION := CMake is an open-source, cross-platform family of tools designed to build, test and package software
include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

SHELL := /bin/bash
build:
	mkdir -p "$(SDESTDIR)"
	cp -a "$(SBUILDDIR)"/* "$(SDESTDIR)"

package: standard_package
