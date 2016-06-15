NAME         := ruby-libvirt-puppet4
VERSION      = 0.6.0
ITERATION_D  := 4
FETCHED_FILE := $(NAME)-$(VERSION).tar.gz
DEPENDS      := "puppet-agent" "libvirt0"
BUILDDEPENDS := gcc make libvirt-dev

PACKAGE_URL := http://libvirt.org/ruby/
PACKAGE_DESCRIPTION := ruby-libvirt provides Ruby bindings for libvirt. With them you can use libvirt directly from your Ruby programs.

include ../include/base.mk

DIST_CODENAME := $(shell facter lsbdistcodename)

$(CACHEDIR)/puppetlabs-release.deb: $(CACHEDIR)/.keep
	curl -L -f -o '$@' https://apt.puppetlabs.com/puppetlabs-release-pc1-$(DIST_CODENAME).deb

install_repos: $(CACHEDIR)/puppetlabs-release.deb
	sudo dpkg -i '$<'
	sudo apt-get update

fetch: install_repos
	cd $(CACHEDIR) && apt-get download puppet-agent

extract:
	dpkg-deb --extract $(CACHEDIR)/puppet-agent_*.deb  '$(SBUILDDIR)'


CHROOT_COMMAND := '/opt/puppetlabs/puppet/bin/gem install ruby-libvirt --version $(VERSION)'
include ../include/overlay_chroot.mk

build:
	$(MAKE) build_on_overlay

package: standard_package

