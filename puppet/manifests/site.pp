node default {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  Exec["apt-get update"] -> Package <| |>

  include devpkg

  class { 'nginx':
    file => 'default',
  }

  include php

  $databases = {
    'lemp' => {
      ensure => 'present',
      charset => 'utf8',
    },
    'iris_sf3_dev' => {
      ensure => 'present',
      charset => 'utf8',
    },
  }

  $users = {
    'lemp@localhost' => {
      ensure                   => 'present',
      max_connections_per_hour => '0',
      max_queries_per_hour     => '0',
      max_updates_per_hour     => '0',
      max_user_connections     => '0',
      password_hash            => '*307164E7BE0B4A606D41480ECEE2C6013DD7260A', # Hash for 'lemp'
    },
  }

  $grants = {
    'lemp@localhost/lemp.*' => {
      ensure     => 'present',
      options    => ['GRANT'],
      privileges => ['ALL'],
      table      => 'lemp.*',
      user       => 'lemp@localhost',
    },
    'lemp@localhost/iris_sf3_dev.*' => {
      ensure     => 'present',
      options    => ['GRANT'],
      privileges => ['ALL'],
      table      => 'iris_sf3_dev.*',
      user       => 'lemp@localhost',
    },
  }

  class { '::mysql::server':
    root_password   => 'lemp-root-password',
    override_options => { 'mysqld' => { 'max_connections' => '1024' } },
    databases => $databases,
    users => $users,
    grants => $grants,
    restart => true,
  }

  include ::mysql::client

  class { 'composer':
    command_name => 'composer',
    target_dir => '/usr/local/bin',
    auto_update  => true,
    require => Package['php5'],
  }

  package { 'postfix':
    ensure => 'present',
  }

  package { 'mailutils':
    ensure => 'present',
  }

  host { 'lemp-stack.local':
    ip => '127.0.0.1',
    host_aliases => 'localhost',
  }

  include iris_sf3
}