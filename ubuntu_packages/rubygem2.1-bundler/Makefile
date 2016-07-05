NAME         := bundler
VERSION      = 1.12.5
ITERATION_D  := 5
DEPENDS      := "ruby2.1"
BUILDDEPENDS := "ruby2.1"

PACKAGE_URL := http://bundler.io/
PACKAGE_DESCRIPTION := Bundler provides a consistent environment for Ruby \
projects by tracking and installing the exact gems and versions that are needed.

FPM_SOURCE := gem
FPM_ARGS   := --gem-package-name-prefix rubygem2.1 \
              --gem-gem /opt/ruby2.1/bin/gem

POSTINSTALL := postinst
PREUNINSTALL := prerm

include ../include/base.mk

package:
	cd $(PKGDIR) && $(FPM_CMD)
