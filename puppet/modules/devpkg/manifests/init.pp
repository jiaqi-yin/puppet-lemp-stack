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

  exec { 'drupal-console':
    command => "/usr/bin/curl https://drupalconsole.com/installer -L -o /usr/local/bin/drupal && chmod a+x /usr/local/bin/drupal",
    creates => '/usr/local/bin/drupal',
    require => Package['curl'],
  }

  drush::drush { 'drush-8.1.8':
    version => '8.1.8',
  }
}