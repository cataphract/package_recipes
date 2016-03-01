NAME         := ruby-libvirt-puppet4
VERSION      = 0.6.0
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "puppet-agent" "libvirt0"
BUILDDEPENDS := gcc make libvirt-dev

PACKAGE_URL := http://libvirt.org/ruby/
PACKAGE_DESCRIPTION := ruby-libvirt provides Ruby bindings for libvirt. With them you can use libvirt directly from your Ruby programs.

include ../include/base.mk

$(CACHEDIR)/puppetlabs-release.deb: $(CACHEDIR)/.keep
	wget -O '$@' https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb

install_repos: $(CACHEDIR)/puppetlabs-release.deb
	sudo dpkg -i '$<'
	sudo apt-get update

fetch: install_repos
	cd $(CACHEDIR) && apt-get download puppet-agent

extract:
	mkdir -p $(SBUILDDIR)
	dpkg-deb --extract $(CACHEDIR)/puppet-agent_*.deb  '$(SBUILDDIR)'

SHELL := /bin/bash

CHROOT_BASE=$(SBUILDDIR)/merged

build:
	mkdir -p $(CHROOT_BASE) $(SDESTDIR)
	mountpoint $(CHROOT_BASE) || sudo mount -t overlayfs overlayfs -o lowerdir=$(SBUILDDIR),upperdir=$(SDESTDIR) $(CHROOT_BASE)
	mkdir -p '$(CHROOT_BASE)'/{usr,bin,lib,lib64,proc,dev}
	cp /etc/resolv.conf $(CHROOT_BASE)/etc
	for d in usr bin lib lib64 proc dev; do \
		mountpoint '$(CHROOT_BASE)'/$$d || sudo mount --rbind /$$d '$(CHROOT_BASE)'/$$d; done
	sudo chroot '$(CHROOT_BASE)' /bin/bash -e -c \
		'/opt/puppetlabs/puppet/bin/gem install ruby-libvirt --version $(VERSION)'
	sudo chown -R $(shell whoami) '$(SDESTDIR)'
	$(MAKE) umount
	rm $(SDESTDIR)/etc/resolv.conf
	rmdir $(SDESTDIR)/{bin,etc,dev,lib,lib64,proc}

package: standard_package

umount:
	for d in usr bin lib lib64 proc dev; do \
		! mountpoint '$(CHROOT_BASE)'/$$d || sudo umount -l '$(CHROOT_BASE)'/$$d; done
	! mountpoint $(CHROOT_BASE) || sudo umount -l $(CHROOT_BASE)
clean: umount
