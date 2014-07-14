class hyperic-agent::install {

case $operatingsystem {
      	/(Debian|Ubuntu)/: { 

	$javapackage = $operatingsystemrelease? {
	 '6.0.7'	 => "sun-java6-jdk",
	 '7.5' 		 => "openjdk-6-jdk",
	 'default' 	 => fail("fail not"),
	 
}
}
      	/(RedHat|CentOS)/: { $javapackage = "java-1.6.0-openjdk" }
      	default: { fail("Unrecognized operating system for JAVA") }
}
	package {'javapackage':
	name   => $javapackage,
	ensure => present,
}

	file {
	"java_home":
	path => '/etc/profile.d/java.sh',
	mode => 755,
	owner =>  root,
	content => template("hyperic-agent/java.sh.erb"),
	require => Package["javapackage"],
}

	exec { 
	"reload-env":
	path => ["/usr/sbin","/bin","/usr/bin"],
	command => "bash -c 'source /etc/profile'",
	require => File["java_home"],
	unless => "test -f /etc/profile.d/java.sh",
}

}
