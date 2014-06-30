name             'example_cookbook'
maintainer       'YOUR_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures example_cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'centos'

depends 'yum-epel', '~> 0.3.6'

recipe 'example_cookbook::default', 'Installs and configures lighttpd'

attribute 'lighttpd/config_file',
          :display_name => 'Lighttpd Configuration File',
          :description => 'Location of configuration file',
          :type => 'string',
          :required => 'optional',
          :recipes => ['example_cookbook::default'],
          :default => '/etc/lighttpd/lighttpd.conf'

attribute 'lighttpd/document_root',
          :display_name => 'Lighttpd Document Root',
          :description => 'Location of document root',
          :type => 'string',
          :required => 'optional',
          :recipes => ['example_cookbook::default'],
          :default => '/var/www/example/'

attribute 'lighttpd/message',
          :display_name => 'Lighttpd Index Message',
          :description => 'Message to display on index.html',
          :type => 'string',
          :required => 'optional',
          :recipes => ['example_cookbook::default'],
          :default => 'This is a test deployment via Chef'

attribute 'lighttpd/port',
          :display_name => 'Lighttpd Port',
          :description => 'Port lighttpd server to run on',
          :required => 'optional',
          :recipes => ['example_cookbook::default'],
          :default => 8080