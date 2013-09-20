# == Class: hqagent
#
# Puppet Module to Install hyperic agent 4.6.0 on nodes CentOS and redhat 6.0 0r superior
#
# === Parameters
#
# Document parameters here.
#   serverip        => IP address hyperic server
#   hquser          => admin user hq server  (usually hqadmin )
#   hquserpassword  => password hqadmin
#
#
# === Examples
#
#     hyperic-agent::config::datahq{'data':
#        serverip        => '10.10.10.1',
#        hquser          => 'hqadmin',
#        hquserpassword  => 'mypasword',
#       }
#
#
# === Authors
#
# Javier Calles <javier.calles@smartmatic.com>
#
# === Copyright
#
# Copyright 2013 Javier Calles
#
class hqagent {
	include hqagent::config
	include hqagent::service
}
