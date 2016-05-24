class devpkg {
  include wget

  $devPkg = ['curl', 'git', 'htop', 'nodejs', 'npm', 'vim', ]

  package { $devPkg:
    ensure => 'installed',
  }

  exec { 'symfony-cli':
    command => "/usr/bin/curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony && chmod a+x /usr/local/bin/symfony",
    creates => '/usr/local/bin/symfony',
    require => Package['curl'],
  }
}