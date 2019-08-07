NAME          := cmake
VERSION       := 3.15.1
SOURCE_URL    := https://www.cmake.org/files/v3.15/$(NAME)-${VERSION}.tar.gz
FETCHED_FILE  := $(NAME)-$(VERSION).tar.gz
TARGET_FORMAT := rpm
DEPENDS       := libcurl shared-mime-info zlib expat xz-libs bzip2
BUILDDEPENDS  := libcurl-devel bzip2-devel shared-mime-info \
	             devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-c++ \
				 zlib-devel expat-devel xz-devel \
				 python27-python-sphinx

PACKAGE_URL := https://cmake.org/
PACKAGE_DESCRIPTION := CMake is an open-source, cross-platform family of tools designed to build, test and package software.

include ../include/base.mk

/etc/yum.repos.d/devtools-2.repo:
	sudo curl $(CURL_PARAMS) -L -f -o $@ http://people.centos.org/tru/devtools-2/devtools-2.repo

install_scl:
	sudo yum install -y centos-release-scl
.PHONY: install_crl

install_builddepends: /etc/yum.repos.d/devtools-2.repo install_scl

DEPS_INSTALL_DIR := $(BUILDDIR)/deps_install

LIBRHASH_URL := https://github.com/rhash/RHash/archive/657825709a7711538d9a19120a990ba5120780fb.tar.gz
LIBRHASH_FILE := $(CACHEDIR)/librhash.tar.gz
LIBRHASH_BUILDDIR := $(BUILDDIR)/librhash
LIBRHASH_LIB := $(DEPS_INSTALL_DIR)/lib/librhash.a

$(LIBRHASH_FILE): $(CACHEDIR)/.keep
	curl $(CURL_PARAMS) -L -f -o $@ '$(LIBRHASH_URL)'

$(LIBRHASH_BUILDDIR): $(LIBRHASH_FILE) $(BUILDDIR)/.keep
	rm -rf '$@'
	mkdir '$@'
	tar -C '$@' --strip-components=1 -xf '$<'

build_librhash: $(LIBRHASH_LIB)
$(LIBRHASH_LIB):
	$(MAKE) $(LIBRHASH_BUILDDIR)
	cd $(LIBRHASH_BUILDDIR) && \
		./configure --prefix="$(DEPS_INSTALL_DIR)" --enable-lib-static
	$(MAKE) -C '$(LIBRHASH_BUILDDIR)' -j4
	$(MAKE) -C '$(LIBRHASH_BUILDDIR)' install

.PRECIOUS: $(LIBRHASH_FILE)
.PHONY: build_librash

fetch: standard_fetch

extract: standard_extract

build: build_librhash
	cd $(SBUILDDIR) && \
		PATH=/opt/rh/devtoolset-2/root/usr/bin:$$PATH \
		LD_LIBRARY_PATH=/opt/rh/devtoolset-2/root/usr/lib64:/opt/rh/devtoolset-2/root/usr/lib:/opt/rh/python27/root/usr/lib64 \
		CXX=/opt/rh/devtoolset-2/root/usr/bin/x86_64-redhat-linux-g++ \
		LIB=$(DEPS_INSTALL_DIR)/lib \
		INCLUDE=$(DEPS_INSTALL_DIR)/include \
		LDFLAGS="-L/opt/rh/devtoolset-2/root/usr/lib/gcc/x86_64-redhat-linux/4.8.2 -static-libstdc++" \
		./bootstrap --prefix=/usr \
			--mandir=/share/man \
			--docdir=/share/doc/cmake \
			--sphinx-man \
			--system-libs \
			--no-system-libarchive \
			--no-system-jsoncpp \
			--no-system-libuv \
			--parallel=4 \
			--sphinx-build=/opt/rh/python27/root/usr/bin/sphinx-build \
			--verbose
	LD_LIBRARY_PATH=/opt/rh/python27/root/usr/lib64 $(MAKE) -j4 -C $(SBUILDDIR) VERBOSE=1
	LD_LIBRARY_PATH=/opt/rh/python27/root/usr/lib64 $(MAKE) -C $(SBUILDDIR) install DESTDIR='$(SDESTDIR)'

package: standard_package
