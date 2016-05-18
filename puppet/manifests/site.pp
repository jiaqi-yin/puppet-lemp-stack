node default {
  class { 'nginx':
    file => 'default',
  }

  include php

  $databases = {
    'lemp' => {
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
}