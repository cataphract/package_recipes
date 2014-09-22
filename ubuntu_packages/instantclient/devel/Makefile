include ../inc.mk

NAME         := oracle-instantclient$(MAJOR_VERSION)-devel
DEPENDS      := "oracle-instantclient$(MAJOR_VERSION)-basiclite | oracle-instantclient$(MAJOR_VERSION)-basic"

PACKAGE_URL := http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html
PACKAGE_DESCRIPTION := Instant Client for Oracle Database (development packages)

include ../../include/base.mk

fetch: standard_fetch

extract:
	mkdir -p $(SBUILDDIR)
	cd $(SBUILDDIR) && \
		fpm -s rpm -t dir -C $(SBUILDDIR) '$(CACHEDIR)/$(FETCHED_FILE)'

build:
	cd $(SBUILDDIR)/* && \
		find . -name 'ottclasses.zip' -delete && \
		rm -r usr/share/oracle/12.1/client64/demo
	cp -a '$(SBUILDDIR)'/*/. '$(SDESTDIR)'

package: standard_package
