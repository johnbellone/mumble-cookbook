#
# Cookbook Name:: mumble
# Recipe:: default
#
# Copyright 2012, AJ Christensen
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package "mumble-server" do
  action :install
end

template "/etc/mumble-server.ini" do
  source "mumble-server.ini.erb"
  owner "root"
  group "mumble-server"
  mode  0640

  notifies :restart, "service[mumble-server]"
end

service "mumble-server" do
  supports :restart => true
  action [ :enable, :start ]
end

execute "set-mumble-superuser-passwd" do
  command "murmurd -ini /etc/mumble-server.ini -supw #{node['mumble']['superuser']['passwd']} && touch /var/lib/mumble-server/supw-set"
  creates "/var/lib/mumble-server/supw-set"
end
  
