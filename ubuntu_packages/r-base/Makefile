NAME         := r-base
VERSION      = 3.2.0
ITERATION    := 2
SOURCE_URL   := http://cran.r-project.org/src/base/R-3/R-$(VERSION).tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "libcairo2" "xfonts-base" "libgfortran3" "libgomp1" \
                "libreadline6" "fonts-dejavu-core" "fonts-texgyre" \
                "texlive-fonts-recommended" "gsfonts-x11" "libpango-1.0-0"
BUILDDEPENDS := "libcairo2-dev" "libxt-dev" "libpango1.0-dev" \
                "texlive-fonts-recommended" "tex-gyre" "libreadline-dev" \
                "build-essential" "gfortran"

PACKAGE_URL := http://cran.r-project.org/
PACKAGE_DESCRIPTION := R is ‘GNU S’, a freely available language and \
environment for statistical computing and graphics

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

R_FLAGS ?= -O2
R_PREFIX := /usr

build:
	cd $(SBUILDDIR) && \
        CFLAGS="$(R_FLAGS)" \
        CXXFLAGS="$(R_FLAGS)" \
        FFLAGS="$(R_FLAGS)" \
        LIBnn=lib \
        LDFLAGS="-Wl,-rpath=$(R_PREFIX)/lib/R/lib,--enable-new-dtags" \
        ./configure --prefix=$(R_PREFIX) \
        --enable-R-shlib --with-readline \
        --enable-R-profiling --enable-memory-profiling \
        --with-libpng --without-jpeglib --without-libtiff \
        --without-system-xz --without-ICU \
        --without-recommended-packages
	$(MAKE) -C $(SBUILDDIR) -j4
	$(MAKE) -C $(SBUILDDIR) install DESTDIR=$(SDESTDIR)

package: standard_package
