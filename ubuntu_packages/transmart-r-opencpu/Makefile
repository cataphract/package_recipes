NAME         := transmart-r-opencpu
_COMMIT      := fa4ae69
VERSION      = 20150805-$(_COMMIT)
SOURCE_URL   := https://github.com/thehyve/opencpuRScripts/archive/$(_COMMIT).tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
# Look at DESCRIPTION for dependencies. This could be automated
DEPENDS      := "r-base-core" "r-cran-gplots" "r-cran-reshape2" "r-cran-httr" \
                "r-cran-reshape"
BUILDDEPENDS := "r-base-dev" $(DEPENDS)

PACKAGE_URL := https://github.com/thehyve/opencpuRScripts

include ../include/base.mk

install_ppa:
	sudo apt-add-repository -y ppa:marutter/rrutter
	sudo apt-add-repository -y ppa:marutter/c2d4u
	sudo apt-get update

install_builddepends: install_ppa

fetch: standard_fetch

extract: standard_extract

build:
	mkdir -p '$(SDESTDIR)'
	R CMD INSTALL -l '$(SDESTDIR)' '$(SBUILDDIR)'

FPM_ARGS += --prefix /usr/lib/R/library

package: standard_package
