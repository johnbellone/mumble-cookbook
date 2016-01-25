#
# Cookbook: mumble
# License: Apache 2.0
#
# Copyright 2012, AJ Christensen
# Copyright 2016, John Bellone <jbellone@bloomberg.net>
#
require 'poise'

module MumbleCookbook
  module Resource
    # A resource which manages Mumble server configuration.
    # @since 1.0
    class MumbleConfig < Chef::Resource
      include Poise(fused: true)
      provides(:mumble_config)

      property(:path, kind_of: String, name_attribute: true)
      property(:owner, kind_of: String, default: 'murmur')
      property(:group, kind_of: String, default: 'murmur')
      property(:mode, kind_of: String, default: '0640')

      attribute(:options, option_collector: true, default: {})

      action(:create) do
        notifying_block do
          directory ::File.dirname(new_resource.path) do
            recursive true
            mode '0755'
            not_if { ::Dir.exist?(path) }
          end

          rc_file new_resource.path do
            type 'ini'
            options new_resource.options
            owner new_resource.owner
            group new_resource.group
            mode new_resource.mode
          end
        end
      end

      action(:delete) do
        rc_file new_resource.path do
          action :delete
        end
      end
    end
  end
end
