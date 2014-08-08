#!/bin/bash

set -e
set -x

VERSION="3.0.3.$(date +%Y%m%d)"
ITERATION=2

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

if [[ $PACKAGE_TYPE = 'rpm' ]]; then
  ln -s lib64 /opt/R/lib
fi

cd /vagrant
fpm \
  --description 'R installation for tranSMART' \
  -a native \
  "${DEP_ARGS[@]}" \
  --version "$VERSION" \
  --iteration "$ITERATION" \
  -n 'transmart-r'  \
  -s dir \
  -t $PACKAGE_TYPE \
  --config-files /etc/default/rserve \
  --config-files $RSERVE_CONF \
  /opt/R \
  /etc/default/rserve \
  /etc/init/rserve.conf \
  $RSERVE_CONF

# vim: set et ts=2 sw=2 ai:
