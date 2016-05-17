class php {
	include apt

	apt::ppa { 'ppa:ondrej/php5-5.6': }

	$enhancers = [
		'php5',
		'php5-fpm',
		'php5-dev',
		'php5-curl',
		'php5-gd',
		'php5-imagick',
		'php5-mcrypt',
		'php5-mhash',
		'php5-pspell',
		'php5-xmlrpc',
		'php5-xsl',
		'php5-cli',
		'php5-json',
		'php5-common',
		'php5-memcache',
		'php5-mysql'
	]

	package { $enhancers:
		ensure => 'present',
		require => Apt::Ppa['ppa:ondrej/php5-5.6']
	}
}