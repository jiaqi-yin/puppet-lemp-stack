class iris_sf3 {

  file { '/etc/nginx/conf.d/iris-sf3.conf':
    source => "puppet:///modules/iris_sf3/iris-sf3.conf",
    owner => 'root',
    group => 'root',
    notify => Service['nginx'],
    require => Package['nginx'],
  }

  file { 'symfony_var_dir':
    path   => '/var/www/project/iris-sf3/var',
    ensure => 'directory',
    owner  => 'vagrant',
    group  => 'vagrant',
    mode   => '0755',
  }

  exec { 'create_cache_link':
    command => '/bin/rm -rf /var/www/project/iris-sf3/var/cache && /bin/ln -s /tmp /var/www/project/iris-sf3/var/cache',
    require => File['symfony_var_dir'],
  }

  exec { 'create_logs_link':
    command => '/bin/rm -rf /var/www/project/iris-sf3/var/logs && /bin/ln -s /tmp /var/www/project/iris-sf3/var/logs',
    require => File['symfony_var_dir'],
  }

  exec { 'create_sessions_link':
    command => '/bin/rm -rf /var/www/project/iris-sf3/var/sessions && /bin/ln -s /tmp /var/www/project/iris-sf3/var/sessions',
    require => File['symfony_var_dir'],
  }
}