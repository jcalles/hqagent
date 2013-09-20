class hqagent::config {
define datahq($serverip, $hquser, $hquserpassword) {

if defined(User['hyperic'])
{
alert("user exist")
}
   else {
  user { 
    'hyperic':
    home       => '/home/hyperic/',
    comment    => 'Privilege-User-Hyperic-Server',
    managehome => true,
    password   => '$6$afqL5bC0Pa0$jqCB/a9zZavUutfe6kSA9cGyXn/Rr5A/cIYjI7HV7FW2vxolnmeYP46zjaIPnYdI3CsTkRCP6.3nCXt0u.H920',
    ensure     => "present",
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
    mode    => '755',
    require => User['hyperic'],

}
	file { 
    'agent-tgz':
		path    => "/home/hyperic/agent-4.6.tar.gz",
    owner   => hyperic,
		group   => hyperic,
    mode    => 775,
    source  => "puppet:///modules/hyperic-agent/agent-4.6.tar.gz",
		require => User['hyperic'],
}
	exec { 
    'hyperic-agent-install':
    cwd     => "/home/hyperic/",
    command => "/bin/tar -xzf agent-4.6.tar.gz",
		user    => "hyperic",
    creates => "/home/hyperic/agent-4.6-EE",
		timeout => 0,
		require => [ User['hyperic'],File['agent-tgz']]
}
  file { 
    'agent':
    path    => "/home/hyperic/agent-4.6-EE/conf/agent.properties",
    owner   => hyperic,
		group   => hyperic, 
    mode    => 755,
		content => template('hyperic-agent/agent.properties.erb'),
		require => Exec['hyperic-agent-install'],
    notify  => Service['hyperic-agent'],
}
	exec { 
    "fix-perms":
    cwd         => "/home/hyperic/",
 		command     => "/bin/chown -Rf hyperic:hyperic *",
		require     => File["agent"],
		refreshonly => 'true',
}
  file { 
    'hyperic-script':
		path    => "/etc/init.d/hyperic-agent",
    owner   => root,
    mode    => 755,
    source  => "puppet:///modules/hyperic-agent/hyperic-agent",
		require => Exec['hyperic-agent-install'],
}

  file { 
    'hyperic-logrotate':
		path   => "/etc/logrotate.d/hyperic-agent",
    owner  => root,
    mode   => 644,
    source => "puppet:///modules/hyperic-agent/hyperic-agent.rotate",
}
}
}
