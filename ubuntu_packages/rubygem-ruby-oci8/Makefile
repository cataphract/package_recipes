NAME         := ruby-oci8
VERSION      := 2.1.8
ITERATION_D  := 1
_IC_VERSION  := 12.1
BUILDDEPENDS := "oracle-instantclient$(_IC_VERSION)-devel"
DEPENDS      := "oracle-instantclient$(_IC_VERSION)-basiclite"

FPM_SOURCE=gem

include ../include/base.mk

package:
	cd $(PKGDIR) && \
        LD_LIBRARY_PATH=/usr/lib/oracle/$(_IC_VERSION)/client64/lib $(FPM_CMD)
