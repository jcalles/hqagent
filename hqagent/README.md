hqagent
-------

Puppet Module to Install hyperic agent 4.6.0 on nodes CentOS and redhat 6.0 0r superior

License
-------
Apache License, Version 2.0

Contact
-------
 Javier Calles <javier.calles@smartmatic.com>

Support
-------

Visit our  [Projects site](https://groups.google.com/forum/#!forum/puppet-venezuela)

Parameters
----------
```ruby
serverip        => IP address hyperic server
hquser          => admin user hq server  (usually hqadmin )
hquserpassword  => password hqadmin
```
Examples
-------
```ruby
    node /fqdn/ {
     include hqagent
     hqagent::config::datahq{'data':
        serverip        => '10.10.10.1',
        hquser          => 'hqadmin',
        hquserpassword  => 'mypasword',
       }

```

Authors
------
Javier Calles <javier.calles@smartmatic.com>

Copyright 2013 Javier Calles
-