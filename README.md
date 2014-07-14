hqagent
-------

Puppet Module to Install hyperic agent 4.6.X or superior on nodes CentOS and RedHat Debian on arch x86_64 and x86.

The packages 'agent-4.6-x86.tar.gz' and 'agent-4.6x86_64.tar.gz' (77MB) is taken from the manual installation of an agent, and the directory 'agent' is the product of zip. Download from https://www.dropbox.com/sh/42feqcleji9yv9l/AAABkogNyIEBR9FpsubScWmra

License
-------
Apache License, Version 2.0

Contact
-------
 Javier Calles <javier.calles@gmail.com>

Support
-------

Visit our  [Projects site](https://groups.google.com/forum/#!forum/puppet-venezuela)

Parameters
----------
```ruby
serverip            => IP address hyperic server
hquser              => admin user hq server  (usually hqadmin )
hquserpassword      => password hqadmin
## The passowd is set  ./hq-agent.sh set-property agent.setup.camPword hqadmin
```
Examples
-------
```ruby
    node /fqdn/ {
     include hqagent
     hqagent::config::datahq{'data':
        serverip        => '10.10.10.1',
        hquser          => 'hqadmin',
        hquserpassword  => 'ENC(DOKTzSEGALXEZKMzCbi8gQ==)',
       }

```

Authors
------
Javier Calles <javier.calles@gmail.com>

Copyright 2014 Javier Calles
-