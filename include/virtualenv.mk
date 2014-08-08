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

ifneq ($(VIRTUALENV_BUILDDEPENDS)$(VIRTUALENV_DEPENDS)1,1)
install_venv_depends: create_virtualenv
	mkdir -p $(SDESTDIR)
	$(VIRTUALENV_ACTIVATE) && \
		pip install $(VIRTUALENV_BUILDDEPENDS) $(VIRTUALENV_DEPENDS)

build: install_venv_depends

.PHONY: install_venv_depends
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
	$(MAKE) symlink_targets maybe_use_system_python

symlink_targets: $(VENV_SYMLINK_TARGETS)

ifdef VIRTUALENV_SYS_PYTHON
FPM_ARGS += -a noarch -d python2.7
PERC := %
maybe_use_system_python:
	cd $(SDESTDIR)/$(FINAL_VENV_DIR)/bin && \
		rm python && \
		ln -s activate_this.py sitecustomize.py && \
		printf '$(PERC)s\n\n$(PERC)s\n$(PERC)s\nexec /usr/bin/python2.7 "$$@"\n' \
			'#!/bin/bash' \
			'DIR="$$(cd "$$(dirname "$${BASH_SOURCE[0]}")" && pwd)"' \
			'export PYTHONPATH="$$DIR:$$PYTHONPATH"' > python && \
		chmod +x python
else
maybe_use_system_python:
	$(info Using embedded python binary, result will not be portable)
endif

.PHONY: symlink_targets maybe_use_system_python

$(VENV_SYMLINK_TARGETS):
	@[ -e $(SDESTDIR)/$(FINAL_VENV_DIR)/bin/$(notdir $@) ] || { \
		echo not found: $(SDESTDIR)/$(FINAL_VENV_DIR)/bin/$(notdir $@); false; }
	mkdir -p $(SDESTDIR)/usr/bin
	ln -s $(FINAL_VENV_DIR)/bin/$(notdir $@) $(SDESTDIR)/usr/bin/$(notdir $@)
