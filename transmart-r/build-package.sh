#!/bin/bash

set -e
set -x

cd /opt/transmart-data/R
export R_PREFIX=/opt/R
export R_FLAGS="-O2"
export RSERVE_CONF=/etc/Rserve.conf
export TRANSMART_USER=transmart

make -j8 /opt/R/bin/R
make install_packages

echo USER=transmart > /etc/default/rserve
PHPRC=/vagrant make install_rserve_upstart

if [[ $(facter operatingsystem) = 'Ubuntu' ]]; then
  PACKAGE_TYPE=deb
  DEPS=('libcairo2' 'xfonts-base' 'libgfortran3' 'libpcre3')
else
  PACKAGE_TYPE=rpm
  DEPS=('cairo' 'xorg-x11-fonts-misc' 'xorg-x11-fonts-Type1'
        'libgfortan' 'pcre')
fi

DEP_ARGS=()
for d in "${DEPS[@]}"; do
  DEP_ARGS+=('-d' "$d")
done

cd /vagrant
fpm \
  --description 'R installation for tranSMART' \
  -a native \
  "${DEP_AGS[@]}" \
  --version "3.0.1.$(date +%Y%m%d)" \
  -n 'transmart-R'  \
  -s dir \
  -t $PACKAGE_TYPE \
  --config-files /etc/default/rserve \
  --config-files $RSERVE_CONF \
  /opt/R \
  /etc/default/rserve \
  /etc/init/rserve.conf \
  $RSERVE_CONF

# vim: set et ts=2 sw=2 ai:
