# based on disqus/fpm-recipes

TOP := $(CURDIR)
BUILDDIR = /tmp/build
CACHEDIR = /tmp/cache
DESTDIR = /tmp/dest
PKGDIR = /vagrant

.PHONY: all clean fetch standard_fetch package standard_package \
        extract standard_extract build install_builddepends
.DELETE_ON_ERROR:

ifndef ITERATION
ITERATION = 1
endif

NULL :=
SPACE := $(NULL) $(NULL)

DQUOTE = "
# Stupid highlighting, let's give it another double-quote "

# Makes '-d "$1"' if $1 is a non-empty string
add_d = $(if $(strip $1),-d "$(strip $1)")

# Replace spaces with +, explode on ", then call add_d after turning + back into spaces
# This is to support: DEPENDS = "package (>= 1.0)" other_pack "some_other_packge"
# GNU Make implictly thinks a space is a delimiter, so have to change it to read the above line
quoted_map = $(foreach i,$(subst $(DQUOTE),$(SPACE),$(subst $(SPACE),+,$2)),$(call $1,$(subst +,$(SPACE),$i)))

ifndef VERSION
$(error Did not specify package version)
endif

FPM_ARGS += $(call quoted_map,add_d,$(DEPENDS))

FPM_ARGS += --iteration $(ITERATION) -v $(VERSION)

ifdef LICENSE
FPM_ARGS += --license $(LICENSE)
endif

ifdef PACKAGE_DESCRIPTION
FPM_ARGS += --description "$(PACKAGE_DESCRIPTION)"
endif

ifdef PACKAGE_PROVIDES
FPM_ARGS += $(foreach pkg,$(PACKAGE_PROVIDES),--provides $(pkg))
endif

ifdef PACKAGE_URL
FPM_ARGS += --url $(PACKAGE_URL)
endif

ifdef PACKAGE_MAINTAINER
FPM_ARGS += --url $(PACKAGE_URL)
endif

ifdef POSTINSTALL
FPM_ARGS += --after-install $(POSTINSTALL)
endif

ifdef POSTUNINSTALL
FPM_ARGS += --after-remove $(POSTUNINSTALL)
endif

ifdef PREINSTALL
FPM_ARGS += --before-install $(PREINSTALL)
endif

ifdef PREUNINSTALL
FPM_ARGS += --before-remove $(PREUNINSTALL)
endif

TARGET_FORMAT ?= deb

FPM_SOURCE ?= dir

ifeq ($(FPM_SOURCE),dir)
FPM_CMD = fpm -t $(TARGET_FORMAT) -s $(FPM_SOURCE) $(FPM_ARGS) -n $(NAME) \
	-C $(SDESTDIR) --deb-user root --deb-group root .
else
FPM_CMD = fpm -t $(TARGET_FORMAT) -s $(FPM_SOURCE) $(FPM_ARGS) $(NAME)
endif

all: build package

WORKING_DIRS := $(foreach d,$(BUILDDIR) $(CACHEDIR) $(DESTDIR) $(PKGDIR),$(d)/.keep)
$(WORKING_DIRS):
	mkdir -p '$(dir $@)'
	touch '$@'

FETCHED_FILE ?= $(notdir $(SOURCE_URL))
FETCHED_FILE_PATH = $(CACHEDIR)/$(FETCHED_FILE)
$(FETCHED_FILE_PATH): $(CACHEDIR)/.keep
	curl -L -f -o $(FETCHED_FILE_PATH) $(SOURCE_URL)

standard_fetch: $(FETCHED_FILE_PATH)

SUBDIR ?= $(NAME)-$(VERSION)
SBUILDDIR = $(BUILDDIR)/$(SUBDIR)

standard_extract: fetch $(BUILDDIR)/.keep
	mkdir -p $(SBUILDDIR)
	bsdtar --strip-components=1 -C $(SBUILDDIR) \
		-xf '$(CACHEDIR)/$(FETCHED_FILE)'

SDESTDIR = $(DESTDIR)/$(SUBDIR)
#no standard_build

ifdef BUILDDEPENDS
install_builddepends:
	sudo apt-get install -y $(BUILDDEPENDS)
endif

standard_package: build $(SDESTDIR)
	cd $(PKGDIR) && $(FPM_CMD)

fetch: $(CACHEDIR)/.keep
extract: $(BUILDDIR)/.keep fetch
build: $(BUILDDIR)/.keep $(DESTDIR)/.keep extract install_builddepends
package: $(PKGDIR)/.keep build

clean:
	rm -rf '$(BUILDDIR)/$(SUBDIR)'
	rm -rf '$(DESTDIR)/$(SUBDIR)'
	bash -c 'rm -rf "$(PKGDIR)/$(NAME)"{-,_}*.{deb,rpm}'

# {{{ Utility Functions
get_date = $(shell date +'%Y%m%d')
# }}}
