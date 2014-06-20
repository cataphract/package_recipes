package { 'fpm':
    provider => 'gem',
    ensure => latest,
    require => [
        Package['rubygems'],
        Package['ruby-devel'],
    ],
}

$native_packages = [
    'cairo-devel',
    'libX11-devel',
    'libXt-devel',
    'rubygems',
    'ruby-devel',
    'php',
]

package { $native_packages: }

file { '/opt':
    owner => 'vagrant',
} ->
vcsrepo { '/opt/transmart-data':
    ensure => latest,
    provider => git,
    source => 'git://github.com/thehyve/transmart-data.git',
    revision => 'master',
    user => 'vagrant',
}
