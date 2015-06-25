NAME         := tmfs
VERSION      := 2013.06.30-a5e201f
SOURCE_URL   := https://github.com/abique/tmfs/archive/a5e201fb7693df253325896e61e7c26e6cc48114.tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "fuse" "libboost-system1.54.0" "libboost-filesystem1.54.0"
BUILDDEPENDS := "libfuse-dev" "g++" "cmake" "libboost-all-dev" "pkg-config"

PACKAGE_URL := https://github.com/abique/tmfs
PACKAGE_DESCRIPTION := Time Machine File System is a read-only virtual \
   	filesystem which helps you to read your Apple\'s time machine backup.

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract


build:
	cd '$(SBUILDDIR)' && cmake -DCMAKE_INSTALL_PREFIX=/usr
	make -C '$(SBUILDDIR)'
	make -C '$(SBUILDDIR)' install DESTDIR='$(SDESTDIR)'

package: standard_package
