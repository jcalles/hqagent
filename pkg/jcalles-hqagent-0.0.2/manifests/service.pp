# Class: hyperic-agent::nstall
#
# This module manages: Run hyperic agent
#
# Parameters:
#
# Actions:
#
# Requires: User hyperic, /home/hyperic/
#
# Sample Usage:
#
# Author: Javier Calles - Smartmatic
#
# [Remember: No empty lines between comments and class definition]
class hyperic-agent::service {
                service { "hyperic-agent":
			ensure => running,
                        hasrestart => true,
                        hasstatus  => true,
                        enable => true,
			#subscribe => File["agent"],
                        require => Class["hyperic-agent::config"],
                        }
}
