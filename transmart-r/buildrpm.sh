#!/bin/bash

set -e
set -x

cd /opt/transmart-data/R
export R_PREFIX=/opt/R
export R_FLAGS="-O2"
make -j8 /opt/R/bin/R
make install_packages

echo USER=transmart > /etc/default/rserve
TRANSMART_USER='$USER' php -d short_open_tag=on -d variables_order=E rserve.php > /etc/init.d/rserve
chmod +x /etc/init.d/rserve

cd /vagrant
fpm \
  --description 'R installation for tranSMART' \
  -a native \
  -d 'cairo' \
  -d 'xorg-x11-fonts-misc' \
  -d 'xorg-x11-fonts-Type1' \
  -d 'libgfortran' \
  -d 'pcre' \
  --version "3.0.1.$(date +%Y%m%d)" \
  -n 'transmart-R'  \
  -s dir \
  -t rpm \
  --config-files /etc/default/rserve \
  /opt/R \
  /etc/default/rserve \
  /etc/init.d/rserve

# vim: set et ts=2 sw=2 ai:
