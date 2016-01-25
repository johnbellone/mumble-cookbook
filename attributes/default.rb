#
# Cookbook: mumble
# License: Apache 2.0
#
# Copyright 2016, John Bellone <jbellone@bloomberg.net>
#
default['mumble']['service_user'] = 'mumble'
default['mumble']['service_group'] = 'mumble'
default['mumble']['service_name'] = 'mumble'

default['mumble']['service']['config_file'] = '/etc/mumble/mumble.ini'
default['mumble']['service']['directory'] = '/var/opt/mumble'
