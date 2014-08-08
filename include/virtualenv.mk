# https://github.com/jordansissel/fpm/issues/697#issuecomment-48880253
#
BUILDDEPENDS += python-pip python-virtualenv

install_virtualenv_tools:
	which virtualenv-tools || sudo pip install virtualenv-tools

create_virtualenv: install_builddepends
	virtualenv --no-site-packages --python /usr/bin/python \
		$(SDESTDIR)

build: create_virtualenv

.PHONY: install_virtualenv_tools create_virtualenv

VIRTUALENV_ACTIVATE := . $(SDESTDIR)/bin/activate

ifdef VIRTUALENV_BUILDDEPENDS
install_venv_builddepends: create_virtualenv
	mkdir -p $(SDESTDIR)
	$(VIRTUALENV_ACTIVATE) && pip install $(VIRTUALENV_BUILDDEPENDS)

build: install_venv_builddepends

.PHONY: install_venv_builddepends
endif

FINAL_VENV_DIR := /usr/share/python/$(NAME)-$(VERSION)
VENV_SYMLINK_TARGETS := $(foreach file,$(VIRTUALENV_BIN_SYMLINKS),$(SDESTDIR)/usr/bin/$(file))

virtualenv_pip_build: install_virtualenv_tools
	$(VIRTUALENV_ACTIVATE) && \
		pip install $(PIP_OPTIONS) $(SBUILDDIR)
	$(VIRTUALENV_ACTIVATE) && \
		pip uninstall -y setuptools pip $(VIRTUALENV_BUILDDEPENDS)
	find '$(SDESTDIR)' -name '*.pyc' -or -name '*.pyo' -delete
	virtualenv-tools --update-path $(FINAL_VENV_DIR) $(SDESTDIR)
	mv $(SDESTDIR) $(SDESTDIR)_
	mkdir -p $(SDESTDIR)/$(FINAL_VENV_DIR)
	mv $(SDESTDIR)_/* $(SDESTDIR)/$(FINAL_VENV_DIR)
	rm -r $(SDESTDIR)_/
	$(MAKE) symlink_targets

symlink_targets: $(VENV_SYMLINK_TARGETS)
.PHONY: symlink_targets

$(VENV_SYMLINK_TARGETS):
	@[ -e $(SDESTDIR)/$(FINAL_VENV_DIR)/bin/$(notdir $@) ] || { \
		echo not found: $(SDESTDIR)/$(FINAL_VENV_DIR)/bin/$(notdir $@); false; }
	mkdir -p $(SDESTDIR)/usr/bin
	ln -s $(FINAL_VENV_DIR)/bin/$(notdir $@) $(SDESTDIR)/usr/bin/$(notdir $@)
