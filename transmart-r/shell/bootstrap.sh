#!/bin/bash

if [[ ! -d /etc/puppet/modules/vcsrepo ]]; then
    yum install -y puppet
    puppet module install puppetlabs-vcsrepo --version 1.0.1
fi
