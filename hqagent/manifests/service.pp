class hqagent::service {

  service { 
    "hyperic-agent":
    ensure      => 'running',
    hasrestart  => true,
    hasstatus   => true,
    enable      => true,
    require     => File['agent-tgz'],
}
}
