node default {
	class { 'nginx':
		file => 'default'
	}
	
	include php

	package { "postfix":
		ensure => present
	}
 
	package { "mailutils":
		ensure => present
	}

	host { 'lemp-stack.local':
		ip => '127.0.0.1',
   		host_aliases => 'localhost'
   	}
}