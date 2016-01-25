#
# Cookbook: mumble
# License: Apache 2.0
#
# Copyright 2016, John Bellone <jbellone@bloomberg.net>
#
if platform_family?('debian')
  include_recipe 'apt::default'

  if platform?('ubuntu')
    apt_repository 'murmur' do
      uri 'http://ppa.launchpad.net/slicer/ppa/ubuntu'
      keyserver 'keyserver.ubuntu.com'
      key '165B2836'
      deb_src true
    end

    include_recipe 'ubuntu::default'
  end
end

if platform_family?('rhel')
  include_recipe 'yum::default', 'yum-epel::default'
  include_recipe 'yum-centos::default' if platform?('centos')
end

poise_service_user node['mumble']['service_user'] do
  group node['mumble']['service_group']
end

mumble_config node['mumble']['service_name'] do
  owner node['mumble']['service_user']
  group node['mumble']['service_group']
  notifies :restart, "mumble_service[#{name}]", :delayed
end

mumble_service node['mumble']['service_name'] do
  user node['mumble']['service_user']
  group node['mumble']['service_group']
end
