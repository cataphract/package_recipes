MAJOR_VERSION := 12.1
VERSION       := 12.1.0.2.0
ITERATION_D   := 1

SOURCE_URL     = http://files.thehyve.net/oracle-rpm/$(VERSION)/$(NAME)-$(VERSION)-1.x86_64.rpm
FETCHED_FILE   = $(notdir $(SOURCE_URL))

BUILDDEPENDS  := patchelf
