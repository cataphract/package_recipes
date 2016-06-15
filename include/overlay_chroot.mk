CHROOT_BASE := $(SBUILDDIR)/merged

ifndef CHROOT_COMMAND
$(error CHROOT_COMMAND must be provided)
endif

SHELL := /bin/bash
FPM_ARGS += --exclude /etc/resolv.conf --exclude /tmp

# This requires a 4.x kernel
# overlay root with the SBUILDDIR and write in SDESTDIR
# we copy resolv.conf because it is a mount point with Docker
build_on_overlay:
	mkdir -p $(CHROOT_BASE) $(SDESTDIR)
	mountpoint $(CHROOT_BASE) || sudo mount -t overlay overlay \
		-o lowerdir=/:$(SBUILDDIR),upperdir=$(SDESTDIR),workdir=$$(mktemp -d) $(CHROOT_BASE)
	sudo rm -f '$(CHROOT_BASE)'/etc/resolv.conf
	cat /etc/resolv.conf | sudo tee '$(CHROOT_BASE)'/etc/resolv.conf
	sudo chroot '$(CHROOT_BASE)' /bin/bash -e -c $(CHROOT_COMMAND)
	$(MAKE) umount_overlay
	sudo rm -f '$(SDESTDIR)'/etc/resolv.conf '$(SDESTDIR)'/tmp
	sudo chown -R $(shell whoami) '$(SDESTDIR)'

umount_overlay:
	! mountpoint $(CHROOT_BASE) || sudo umount -l $(CHROOT_BASE)
clean: umount
