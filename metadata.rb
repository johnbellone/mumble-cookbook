name 'mumble'
maintainer 'John Bellone'
maintainer_email 'jbellone@bloomberg.net'
license 'Apache 2.0'
description 'Application cookbook which installs and configures Mumble client and server.'
long_description 'Application cookbook which installs and configures Mumble client and server.'
version '1.0.0'

supports 'fedora'
supports 'centos', '>= 7.0'
supports 'ubuntu', '>= 12.04'

depends 'apt'
depends 'libartifact'
depends 'rc', '~> 1.5'
depends 'poise-service'
depends 'selinux'
depends 'ubuntu'
depends 'yum'
depends 'yum-centos'
depends 'yum-fedora'
