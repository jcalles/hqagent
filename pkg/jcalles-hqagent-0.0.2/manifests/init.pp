# == Class: hyperic
#
# Puppet Module to Install hyperic agent 4.6.0 on nodes CentOS and redhat 6.0 0r superior
#
# === Parameters
#   serverip        => IP address hyperic server
#   hquser          => admin user hq server  (usually hqadmin )
#   hquserpassword  => password hqadmin
#
# === Examples
#
#     hyperic-agent::config::datahq{'data':
#        serverip        => '10.10.10.1',
#        hquser          => 'hqadmin',
#        hquserpassword  => 'mypasword',

## The passowd is set  ./hq-agent.sh set-property agent.setup.camPword hqadmin
#
# === Authors
#
# Javier Calles <javier.calles@smartmatic.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
# Author: Javier Calles
#
class hyperic-agent {
	include hyperic-agent::config
	include hyperic-agent::service
	include hyperic-agent::install
}
