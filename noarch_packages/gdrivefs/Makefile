NAME         := gdrivefs
VERSION      := 0.13.14
ITERATION    := 2
SOURCE_URL   := https://github.com/dsoprea/GDriveFS/archive/0.13.14.tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
BUILDDEPENDS := git
DEPENDS      := fuse
ifeq ($(TARGET_FORMAT),rpm)
DEPENDS      += libfuse
endif

PACKAGE_URL := https://github.com/dsoprea/GDriveFS
PACKAGE_DESCRIPTION := An innovative FUSE wrapper for Google Drive

include ../include/base.mk

VIRTUALENV_SYS_PYTHON   := 1
VIRTUALENV_BUILDDEPENDS := ez-setup
VIRTUALENV_BIN_SYMLINKS := gdfs gdfstool
PIP_OPTIONS := --allow-unverified antlr-python-runtime --allow-external antlr-python-runtime

include ../include/virtualenv.mk

fetch: standard_fetch

extract: standard_extract

build: install_google_api_python_client
	$(MAKE) virtualenv_pip_build
	echo done

package: standard_package

# note in the readme says to install this by hand (not from pip)
# note also gdrivefs doesn't formally declare it as a dependency, but it's required
# the symlink is because gdrivefs imports the google apiclient as 'apiclient'
# instead of 'googleapiclient'
install_google_api_python_client: create_virtualenv $(BUILDDIR)/.keep
	[ -d $(BUILDDIR)/google-api-python-client ] || { cd $(BUILDDIR) && \
		git clone --depth 1 -b master https://github.com/google/google-api-python-client && \
		cd google-api-python-client && \
		git submodule init && git submodule update && \
		$(VIRTUALENV_ACTIVATE) && \
		pip install . && \
		ln -s googleapiclient $(SDESTDIR)/lib/python2.7/site-packages/apiclient; } 

clean: remove_google_api_python_client_checkout
remove_google_api_python_client_checkout:
	rm -rf '$(BUILDDIR)/google-api-python-client'

.PHONY: install_google_api_python_client remove_google_api_python_client_checkout
