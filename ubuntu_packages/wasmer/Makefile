NAME         := wasmer
VERSION      := 1.0.2
ITERATION_D  := 1
SOURCE_URL   := https://github.com/wasmerio/wasmer/releases/download/$(VERSION)/wasmer-linux-amd64.tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz

PACKAGE_URL := https://github.com/wasmerio/wasmer/
PACKAGE_DESCRIPTION := The leading WebAssembly Runtime supporting WASI and Emscripten

STRIP_COMPONENTS := 0

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

SHELL := /bin/bash

build:
	mkdir -p '$(SDESTDIR)'/usr
	ls '/tmp/build/wasmer-1.0.2'
	mv '$(SBUILDDIR)'/{include,bin,lib} '$(SDESTDIR)'/usr

package: standard_package
