if $::operatingsystem == 'Ubuntu' {
    $native_packages = [
        'libcairo2-dev',
        'libxt-dev',
        'libreadline-dev',
        'ruby-dev',
        'php5-cli',
        'build-essential',
        'gfortran',
        'git', # centos mach
    ]
    $gem_req = Package['ruby-dev']
} else {
    $native_packages = [
        'cairo-devel',
        'libX11-devel',
        'libXt-devel',
        'readline-devel',
        'rubygems',
        'ruby-devel',
        'php',
        'git',
        'gcc-g++',
        'gcc-gfortan',
        'rpm-build',
    ]
    $gem_req = [
        Package['rubygems'],
        Package['ruby-devel'],
    ]
}

package { 'fpm':
    provider => 'gem',
    ensure   => latest,
    require  => $gem_req,
}

package { $native_packages: }

file { '/opt':
    owner => 'vagrant',
} ->
vcsrepo { '/opt/transmart-data':
    ensure   => latest,
    provider => git,
    source   => 'git://github.com/thehyve/transmart-data.git',
    revision => 'master',
    user     => 'vagrant',
}

Package['git'] -> Vcsrepo <| |>
