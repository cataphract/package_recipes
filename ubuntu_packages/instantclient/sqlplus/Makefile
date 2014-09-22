include ../inc.mk

NAME         := oracle-instantclient$(MAJOR_VERSION)-sqlplus
DEPENDS      := "oracle-instantclient$(MAJOR_VERSION)-basiclite | oracle-instantclient$(MAJOR_VERSION)-basic"

PACKAGE_URL := http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html
PACKAGE_DESCRIPTION := Instant Client for Oracle Database (sqlplus)

include ../../include/base.mk

fetch: standard_fetch

extract:
	mkdir -p $(SBUILDDIR)
	cd $(SBUILDDIR) && \
		fpm -s rpm -t dir -C $(SBUILDDIR) '$(CACHEDIR)/$(FETCHED_FILE)'

build:
	cd $(SBUILDDIR)/* && \
		find usr/bin -type f -o -type l -delete && \
		find usr/lib/oracle/$(MAJOR_VERSION)/client64/bin -type f -exec \
			patchelf --set-rpath '$$ORIGIN/../lib' '{}' \; && \
		find usr/lib/oracle/$(MAJOR_VERSION)/client64/bin -type f -exec \
			ln -s '/{}' usr/bin \;
	cp -a '$(SBUILDDIR)'/*/. '$(SDESTDIR)'

package: standard_package
