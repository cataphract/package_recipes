#!/bin/bash

yum install -y rubygems ruby-devel
gem install fpm

# fake bsdtar, though we won't be able to use it to extract zips etc
# I may have to install the real thing in the future
if [[ ! -L /usr/local/bin/bsdtar ]]; then
	ln -s /bin/tar /usr/local/bin/bsdtar
fi
