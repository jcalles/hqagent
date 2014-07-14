class hyperic-agent::config {
define datahq($serverip, $hquser, $hquserpassword) {

if defined(User['hyperic'])
{
alert("user exist")
}
        else {

        user { 'hyperic':
                home       => '/home/hyperic/',
                comment    => 'Privilege-User-Hyperic-Server',
                managehome => true,
                password   => '$6$afqL5bC0Pa0$jqCB/a9zZavUutfe6kSA9cGyXn/Rr5A/cIYjI7HV7FW2vxolnmeYP46zjaIPnYdI3CsTkRCP6.3nCXt0u.H920',
                ensure     => "present",
                shell      => '/bin/bash',
                gid        => '1500',
                uid        => '1500',
}
        group { 'hyperic':
                 ensure => 'present',
                 gid    => '1500',
}
}

	case $architecture {
	'i386': { $hyperic_agent =  "agent-4.6-x86.tar.gz"}
	'x86_64': { $hyperic_agent =  "agent-4.6-x86_64.tar.gz"}
      	default: { fail("Unrecognized operating system") }

}
###  Copia archivo comprimido a /home
	file { 'agent-tgz':
		path   => "/home/hyperic/$hyperic_agent",
                owner  => hyperic,
		group  => hyperic,
                mode   => 775,
                source => "puppet:///modules/hyperic-agent/$hyperic_agent",
		require => User['hyperic'],
}
###  DEscomprime el archivo de instalacion
	exec { 'hyperic-agent-install':
                cwd     => "/home/hyperic/",
                command => "/bin/tar -xzf $hyperic_agent",
		user    => "hyperic",
                creates => "/home/hyperic/agent",
		timeout => 0,
		require => [ User['hyperic'],File['agent-tgz']]
}
###   Copia el archivo de configuracion para la instalacion 
       file { 'agent':
		path   => "/home/hyperic/agent/conf/agent.properties",
                owner  => hyperic,
		group  => hyperic, 
                mode   => 755,
		content => template('hyperic-agent/agent.properties.erb'),
		require => Exec['hyperic-agent-install'],
}
#################################################################################
#
###  Restablece los permisos del usuario hyperic
	exec { "fix-perms":
      		cwd => "/home/hyperic/",
      		command => "/bin/chown -Rf hyperic:hyperic *",
      		require => File["agent"],
		refreshonly => 'true',
   }
###  Copia el a archivo de inicio del servicio de hyperic
        file { 'hyperic-script':
		path   => "/etc/init.d/hyperic-agent",
                owner  => root,
                mode   => 755,
                content => template("hyperic-agent/hyperic-agent.erb"),
		require => Exec['hyperic-agent-install'],
}

###  Copia el a archivo de logrotate del servicio de hyperic
        file { 'hyperic-logrotate':
		path   => "/etc/logrotate.d/hyperic-agent",
                owner  => root,
                mode   => 644,
                source => "puppet:///modules/hyperic-agent/hyperic-agent.rotate",
}
}
}
