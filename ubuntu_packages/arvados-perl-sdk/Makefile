NAME         := arvados-perl-sdk
VERSION      = 20160218
_COMMIT      := fd5fc5a6c2cc3bec082877627d8d395950024930
ITERATION_D  := 4
DEPENDS      := "libjson-perl" "libio-socket-ssl-perl" "libwww-perl" "libipc-system-simple-perl" "libcrypt-ssleay-perl"
BUILDDEPENDS := "libjson-perl" "libio-socket-ssl-perl" "libwww-perl" "libipc-system-simple-perl" "libcrypt-ssleay-perl" "git"
CONFLICTS    := "libarvados-perl"
SOURCE_URL   := https://github.com/curoverse/arvados/archive/$(_COMMIT).tar.gz

PACKAGE_URL := https://arvados.org/
PACKAGE_DESCRIPTION  := Arvados Perl SDK

include ../include/base.mk

SHELL := /bin/bash

install_arvados_repos:
	echo deb http://apt.arvados.org/ $(shell facter lsbdistcodename) main | sudo tee /etc/apt/sources.list.d/arvados.list
	sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 1078ECD7
	sudo apt-get update

install_builddepends: install_arvados_repos

fetch: standard_fetch

extract: standard_extract

build:
	cd $(SBUILDDIR)/sdk/perl && perl Makefile.PL INSTALLDIRS=vendor
	$(MAKE) -C $(SBUILDDIR)/sdk/perl OPTIMIZE="-O2 -g -Wall"
	$(MAKE) -C $(SBUILDDIR)/sdk/perl install DESTDIR='$(SDESTDIR)'

package: standard_package
