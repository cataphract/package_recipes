NAME         := libtcnative-1
VERSION      := 1.1.33
SOURCE_URL   := http://mirror.nl.webzilla.com/apache/tomcat/tomcat-connectors/native/$(VERSION)/source/tomcat-native-$(VERSION)-src.tar.gz
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "openssl" "apr"
BUILDDEPENDS := "openssl-devel" "java-1.7.0-openjdk-devel" "apr-devel"

PACKAGE_URL := http://tomcat.apache.org/native-doc/
PACKAGE_DESCRIPTION := The Apache Tomcat Native Library is an optional \
	component for use with Apache Tomcat that allows Tomcat to use certain \
	native resources for performance, compatibility, etc.

include /vagrant/include/base.mk

fetch: standard_fetch

extract: standard_extract

SHELL := /bin/bash

PREFIX := /usr
build:
	cd '$(SBUILDDIR)/jni/native' && \
		JAVA_HOME='/usr/lib/jvm/java-1.7.0' ./configure \
		--with-apr=/usr \
		--with-ssl=/usr \
		--prefix=$(PREFIX)
	$(MAKE) -j8 -C '$(SBUILDDIR)/jni/native'
	$(MAKE) -C '$(SBUILDDIR)/jni/native' install DESTDIR='$(SDESTDIR)'
	rm -rf '$(SDESTDIR)'/$(PREFIX)/{bin,include,lib/pkgconfig,lib/*.a,lib/*.la}

package: standard_package
