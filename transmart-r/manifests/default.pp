if $::operatingsystem == 'Ubuntu' {
    $native_packages = [
        'libcairo2-dev',
        'libxt-dev',
        'libpango1.0-dev',
        'texlive-fonts-recommended',
        'tex-gyre', # textlive-fonts-recommended recommends this package
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
        'pango-devel',
        'texlive-texmf-fonts',
        'urw-fonts',
        'readline-devel',
        'rubygems',
        'ruby-devel',
        'php',
        'git',
        $::operatingsystemmajrelease ? { 6 => 'gcc-g++', default => 'gcc-c++' },
        'gcc-gfortran',
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
    source   => 'git://github.com/transmart/transmart-data.git',
    revision => 'master',
    user     => 'vagrant',
}

Package['git'] -> Vcsrepo <| |>
