#
# Cookbook: mumble
# License: Apache 2.0
#
# Copyright 2012, AJ Christensen
# Copyright 2016, John Bellone <jbellone@bloomberg.net>
#
if platform_family?('debian')
  include_recipe 'apt::default'

  if platform?('ubuntu')
    apt_repository 'mumble' do
      uri 'http://ppa.launchpad.net/mumble/release/ubuntu'
      keyserver 'keyserver.ubuntu.com'
      key '7F05CF9E'
      deb_src true
    end

    include_recipe 'ubuntu::default'
  end
end

if platform_family?('rhel')
  include_recipe 'yum::default'
  include_recipe 'yum-centos::default' if platform?('centos')
  include_recipe 'yum-fedora::default' if platform?('fedora')
end

package node['mumble']['package_name'] do
  version node['mumble']['package_version'] if node['mumble']['package_version']
  action :upgrade
end
