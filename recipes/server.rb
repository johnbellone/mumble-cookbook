#
# Cookbook: mumble
# License: Apache 2.0
#
# Copyright 2012, AJ Christensen
# Copyright 2016, John Bellone <jbellone@bloomberg.net>
#
include_recipe 'rc::default', 'selinux::disabled'

poise_service_user node['murmur']['service_user'] do
  group node['murmur']['service_group']
end

murmur_config node['murmur']['service_name'] do |r|
  owner node['murmur']['service_user']
  group node['murmur']['service_group']
  node['murmur']['config'].each_pair { |k, v| r.send(k, v) }
  notifies :restart, "murmur_service[#{name}]", :delayed
end

murmur_service node['murmur']['service_name'] do |r|
  user node['murmur']['service_user']
  group node['murmur']['service_group']
  node['murmur']['service'].each_pair { |k, v| r.send(k, v) }
end
