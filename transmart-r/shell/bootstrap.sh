#!/bin/bash

if [[ ! -d /etc/puppet/modules/vcsrepo ]]; then
  if command -v apt-get; then
    apt-get update
    apt-get install -y puppet
  else
    yum install -y puppet
  fi
    puppet module install puppetlabs-vcsrepo --version 1.0.1
fi
