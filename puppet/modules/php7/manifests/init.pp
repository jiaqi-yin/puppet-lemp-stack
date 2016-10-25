class php7 {
  include apt

  apt::ppa { 'ppa:ondrej/php': }

  $enhancers = [
    'php7.0',
    'php7.0-fpm',
    'php7.0-dev',
    'php7.0-curl',
    'php7.0-gd',
    'php7.0-imagick',
    'php7.0-mcrypt',
    'php7.0-pspell',
    'php7.0-xmlrpc',
    'php7.0-xsl',
    'php7.0-cli',
    'php7.0-json',
    'php7.0-common',
    'php7.0-memcache',
    'php7.0-mysql',
    'php7.0-intl',
  ]

  package { $enhancers:
    ensure => 'present',
    require => [
      Apt::Ppa['ppa:ondrej/php'],
      Class['apt::update'],
    ]
  }
}