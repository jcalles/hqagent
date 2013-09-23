class hqagent::config {
define datahq($serverip, $hquser, $hquserpassword) {

if defined(User['hyperic'])
{
alert('user exist')
}
   else {
  user { 
    'hyperic':
    home       => '/home/hyperic/',
    comment    => 'Privilege-User-Hyperic-Server',
    managehome => true,
    password   => '$6$afqL5bC0Pa0$jqCB/a9zZavUutfe6kSA9cGyXn/Rr5A/cIYjI7HV7FW2vxolnmeYP46zjaIPnYdI3CsTkRCP6.3nCXt0u.H920',
    ensure     => 'present',
    shell      => '/bin/bash',
    gid        => '1500',
    uid        => '1500',
}
    group { 
    'hyperic':
    ensure => 'present',
    gid    => '1500',
}
}
  file {
    '/home/hyperic/':
    ensure  => 'directory',
    owner   => 'hyperic',
    mode    => '0755',
    require => User['hyperic'],

}
	file { 
    'agent-tgz':
		path    => "/home/hyperic/${::release}",
    owner   => hyperic,
		group   => hyperic,
    mode    => 0775,
    source  => "puppet:///modules/hqagent/${release}",
		require => User['hyperic'],
}
	exec { 
    'hyperic-agent-install':
    cwd     => '/home/hyperic/',
    command => "/bin/tar -xzf ${release}",
		user    => 'hyperic',
 #   creates => "/home/hyperic/agent-4.6-EE",
    creates => "/home/hyperic/${releasehome}",
		timeout => 0,
		require => [ User['hyperic'],File['agent-tgz']]
}
  file { 
    'agent':
    path    => "/home/hyperic/${releasehome}/conf/agent.properties",
    owner   => hyperic,
		group   => hyperic, 
    mode    => 0755,
		content => template('hqagent/agent.properties.erb'),
		require => Exec['hyperic-agent-install'],
    notify  => Service['hyperic-agent'],
}
	exec { 
    'fix-perms':
    cwd         => "/home/hyperic/",
 		command     => "/bin/chown -Rf hyperic:hyperic *",
		require     => File["agent"],
		refreshonly => true,
}
  file { 
    'hyperic-script':
		path    => "/etc/init.d/hyperic-agent",
    owner   => root,
    mode    => 0755,
    source  => "puppet:///modules/hqagent/hyperic-agent",
		require => Exec['hyperic-agent-install'],
}

  file { 
    'hyperic-logrotate':
		path   => "/etc/logrotate.d/hyperic-agent",
    owner  => root,
    mode   => 0644,
    source => "puppet:///modules/hqagent/hyperic-agent.rotate",
}
}
}
