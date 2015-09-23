# base should have been included

ifndef GO_VERSION
$(error Did not specify go version)
endif

GO_SOURCE_URL := https://storage.googleapis.com/golang/go$(GO_VERSION).linux-amd64.tar.gz

GOROOT := $(BUILDDIR)/go-$(GO_VERSION)
GO_BIN := $(GOROOT)/bin/go

GO_FETCHED_FILE := $(notdir $(GO_SOURCE_URL))
GO_FETCHED_FILE_PATH = $(CACHEDIR)/$(GO_FETCHED_FILE)
$(GO_FETCHED_FILE_PATH): $(CACHEDIR)/.keep
	curl $(CURL_PARAMS) -L -f -o $(GO_FETCHED_FILE_PATH) $(GO_SOURCE_URL)

$(GO_BIN): $(GO_FETCHED_FILE_PATH) $(BUILDDIR)/.keep
	rm -rf '$(GOROOT)'
	mkdir '$(GOROOT)'
	tar -C '$(GOROOT)' --strip-components=1 -xf '$<'
	touch '$@'

fetch: $(GO_FETCHED_FILE_PATH)

extract: $(GO_BIN)

PATH := $(dir $(GO_BIN)):$(PATH)
export PATH
export GOROOT
