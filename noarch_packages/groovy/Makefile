NAME         := groovy
VERSION      = 2.4.8
ITERATION    := 2
SOURCE_URL   := https://dl.bintray.com/groovy/maven/apache-groovy-binary-$(VERSION).zip
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := default-jdk-headless
FPM_ARGS     := -a noarch

PACKAGE_URL := http://www.groovy-lang.org/
PACKAGE_DESCRIPTION := Apache Groovy is a powerful, optionally typed and \
  dynamic language, with static-typing and static compilation capabilities, \
  for the Java platform aimed at improving developer productivity thanks to a \
  concise, familiar and easy to learn syntax.

include ../include/base.mk

fetch: standard_fetch

extract: standard_extract

SHELL := /bin/bash
build:
	cd $(SBUILDDIR) && \
		find . -name '*.bat' -delete && \
		rm -rf grooid && \
		find lib -name 'groovy-*.jar' -delete && \
		cd indy && find -name '*.jar' -print0 | while read -d $$'\0' f; do cp "$$f" ../lib/"$${f%-indy.jar}".jar; done
	mkdir -p $(SDESTDIR)/{usr/share/groovy,usr/bin}
	cp -a $(SBUILDDIR)/{lib,conf,bin} $(SDESTDIR)/usr/share/groovy
	cd $(SDESTDIR) && find usr/share/groovy/bin -type f -exec ln -s /'{}' usr/bin \;

package: standard_package
