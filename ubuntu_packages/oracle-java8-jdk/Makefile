# based on webupd8 ppa's package
#
NAME         := oracle-java8-jdk
_RELEASE     := 66
_BUILD       := 17
_JAVA_VERSION:= 8u$(_RELEASE)
VERSION      := $(_JAVA_VERSION)
ITERATION    := 1
_FILENAME    :=jdk-${_JAVA_VERSION}-linux-x64.tar.gz
SOURCE_URL   := http://download.oracle.com/otn-pub/java/jdk/$(_JAVA_VERSION)-b$(_BUILD)/$(_FILENAME)
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "ca-certificates-java" "java-common" "locales"
CONFLICTS    := "j2se-common"
BUILDDEPENDS := "bsdtar"
PROVIDES     := "java-virtual-machine" "java-compiler" "default-jre" \
	            "default-jre-headless" "java-runtime" "java2-runtime" \
				"java5-runtime" "java6-runtime" "java7-runtime" \
				"java8-runtime" "java-runtime-headless" \
				"java2-runtime-headless" "java5-runtime-headless" \
				"java6-runtime-headless" "java7-runtime-headless" \
				"java8-runtime-headless" "java-jdk" "java2-jdk" "java5-jdk" \
				"java6-jdk" "java7-jdk" "java-sdk" "java2-sdk" "java5-sdk" \
				"java6-sdk" "java7-sdk" "openjdk-6-jre" \
				"openjdk-6-jre-headless" "icedtea-6-plugin" "openjdk-7-jre" \
				"openjdk-7-jre-headless" "openjdk-7-jdk" "icedtea-7-plugin" \
				"oracle-java7-bin" "oracle-java7-jre" "oracle-java7-jdk" \
				"oracle-java7-fonts" "oracle-java7-plugin" "oracle-java8-bin" \
				"oracle-java8-jre" "oracle-java8-fonts" "oracle-java8-plugin" \
				"java8-jdk" "java8-sdk"
REPLACES     := "openjdk-6-jre" "openjdk-6-jre-headless" "icedtea-6-plugin" \
				"openjdk-7-jre" "openjdk-7-jre-headless" "openjdk-7-jdk" \
				"icedtea-7-plugin" "oracle-java7-bin" "oracle-java7-jre" \
				"oracle-java7-jdk" "oracle-java7-fonts" "oracle-java7-plugin" \
				"oracle-jdk7-installer" "oracle-java8-bin" "oracle-java8-jre" \
				"oracle-java8-fonts" "oracle-java8-plugin" \
				"oracle-jdk8-installer"

PACKAGE_URL         := http://www.oracle.com/
PACKAGE_DESCRIPTION := Oracle Java(TM) Development Kit (JDK) 8
POSTINSTALL         := postinst
PREUNINSTALL        := prerm
POSTUNINSTALL       := postrm
CURL_PARAMS         := -H "Cookie: oraclelicense=a"
_POLICY_FILE        := jce_policy-8.zip
_POLICY_URL         := http://download.oracle.com/otn-pub/java/jce/8/$(_POLICY_FILE)

include ../include/base.mk


fetch: standard_fetch $(FETCHED_FILE_PATH)

POLICY_FETCHED_FILE_PATH = $(CACHEDIR)/$(_POLICY_FILE)
$(POLICY_FETCHED_FILE_PATH): $(CACHEDIR)/.keep
	curl $(CURL_PARAMS) -L -f -o $(POLICY_FETCHED_FILE_PATH) $(_POLICY_URL)


extract: standard_extract policy_extract

POLICY_SBUILDDIR = $(BUILDDIR)/jce_policy-8
policy_extract: $(POLICY_FETCHED_FILE_PATH) $(BUILDDIR)/.keep
	mkdir -p $(POLICY_SBUILDDIR)
	bsdtar --strip-components=1 -C $(POLICY_SBUILDDIR) \
		-xf '$(POLICY_FETCHED_FILE_PATH)'

INSTALL_DIR := /usr/lib/jvm/java-8-oracle
DEST_INSTALL_DIR := $(SDESTDIR)$(INSTALL_DIR)

SHELL := bash

build:
	mkdir -p $(DEST_INSTALL_DIR)
	cp -a $(SBUILDDIR)/. $(DEST_INSTALL_DIR)
#
	mv $(DEST_INSTALL_DIR)/jre/bin/javaws $(DEST_INSTALL_DIR)/jre/bin/javaws.real
	install -m 755 javaws-wrapper.sh $(DEST_INSTALL_DIR)/jre/bin/javaws
	install -m 755 jar.binfmt $(DEST_INSTALL_DIR)/jre/lib/jar.binfmt
	install -m 755 fontconfig.Ubuntu.properties $(DEST_INSTALL_DIR)/jre/lib/
# gzip man pages
	ls $(DEST_INSTALL_DIR)/man/man1/*.1 >/dev/null 2>&1 && \
		gzip -9 $(DEST_INSTALL_DIR)/man/man1/*.1 >/dev/null 2>&1
# use certificates from java-ca-certificates instead
	cd $(DEST_INSTALL_DIR)/jre/lib/security && \
		mv cacerts cacerts.original && \
		ln -s /etc/ssl/certs/java/cacerts .
#
	mkdir -p $(SDESTDIR)/usr/share/pixmaps
	install -m 644 oracle_java8.xpm $(SDESTDIR)/usr/share/pixmaps/
	install -m 644 oracle_java8.png $(SDESTDIR)/usr/share/pixmaps/
	mkdir -p $(SDESTDIR)/usr/share/applications/
	install -m 755 *.desktop $(SDESTDIR)/usr/share/applications/
	mkdir -p $(SDESTDIR)/usr/share/application-registry/
	install -m 644 *.applications $(SDESTDIR)/usr/share/application-registry/
	mkdir -p $(SDESTDIR)/usr/share/mime-info/
	install -m 644 *.mime *.keys $(SDESTDIR)/usr/share/mime-info/
# unlimited policy
	mkdir -p $(DEST_INSTALL_DIR)/jre/lib/security/
	cp '$(POLICY_SBUILDDIR)'/*.jar $(DEST_INSTALL_DIR)/jre/lib/security/

package: standard_package
