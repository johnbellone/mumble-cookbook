#
# Cookbook: mumble
# License: Apache 2.0
#
# Copyright 2012, AJ Christensen
# Copyright 2016, John Bellone <jbellone@bloomberg.net>
#
default['mumble']['package_name'] = 'mumble'

default['murmur']['service_user'] = 'murmur'
default['murmur']['service_group'] = 'murmur'
default['murmur']['service_name'] = 'murmur'

default['murmur']['config']['options']['database'] = '/var/lib/murmur.sqlite'

default['murmur']['service']['version'] = '1.2.13'
default['murmur']['service']['binary_url'] = "https://github.com/mumble-voip/mumble/releases/download/%(version)/murmur-static_x86-%(version).tar.bz2"
default['murmur']['service']['binary_checksum'] = 'ff4e8244f9f51bde653fe8bab1b97a8dea6715802b7a7a1991a03e0d2bcc8447'
default['murmur']['service']['config_file'] = '/etc/murmur.ini'
default['murmur']['service']['directory'] = '/var/lib/murmur'
