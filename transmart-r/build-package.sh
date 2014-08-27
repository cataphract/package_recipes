#!/bin/bash

set -e
set -x

VERSION="3.0.3.$(date +%Y%m%d)"
ITERATION=3

cd /opt/transmart-data/R
export R_PREFIX=/opt/R
export R_FLAGS="-O2"
export RSERVE_CONF=/etc/Rserve.conf
export TRANSMART_USER=transmart

if [[ -x /usr/bin/systemctl ]]; then
  USE_SYSTEMD=1
fi

if [[ $USE_SYSTEMD = 1 ]]; then
  INSTALL_TARGET=install_rserve_unit
  SERVICE_FILE=/usr/lib/systemd/system/rserve.service
  PACKAGE_NAME='transmart-r-systemd'
  USER_CONFIG_FILE=/etc/systemd/system/rserve.service.d/rserve-user.conf
  sudo mkdir -p "$(dirname "$USER_CONFIG_FILE")"
  echo -e '[Service]\nUser=transmart' | sudo tee "$USER_CONFIG_FILE"
else
  INSTALL_TARGET=install_rserve_upstart
  SERVICE_FILE=/etc/init/rserve.conf
  PACKAGE_NAME='transmart-r'
  USER_CONFIG_FILE=/etc/default/rserve
  echo USER=transmart | sudo tee $USER_CONFIG_FILE
fi

make -j8 /opt/R/bin/R
make install_packages

PHPRC=/vagrant sudo -E make $INSTALL_TARGET
if [[ $USE_SYSTEMD = 1 ]]; then
  sudo mv /etc/systemd/system/rserve.service $SERVICE_FILE
fi

if [[ $(facter operatingsystem) = 'Ubuntu' ]]; then
  PACKAGE_TYPE=deb
  DEPS=('libcairo2' 'xfonts-base' 'libgfortran3' 'libgomp1' 'libreadline6')
else
  PACKAGE_TYPE=rpm
  DEPS=('cairo' 'xorg-x11-fonts-misc' 'xorg-x11-fonts-Type1'
        'libgfortran' 'readline' 'libgomp')
fi

DEP_ARGS=()
for d in "${DEPS[@]}"; do
  DEP_ARGS+=('-d' "$d")
done

cd /vagrant
fpm \
  --description 'R installation for tranSMART' \
  -a native \
  "${DEP_ARGS[@]}" \
  --version "$VERSION" \
  --iteration "$ITERATION" \
  -n "$PACKAGE_NAME"  \
  -s dir \
  -t $PACKAGE_TYPE \
  --config-files $USER_CONFIG_FILE \
  --config-files $RSERVE_CONF \
  /opt/R \
  $USER_CONFIG_FILE \
  $SERVICE_FILE \
  $RSERVE_CONF

# vim: set et ts=2 sw=2 ai:
