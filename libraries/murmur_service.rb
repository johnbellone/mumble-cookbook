#
# Cookbook: mumble
# License: Apache 2.0
#
# Copyright 2012, AJ Christensen
# Copyright 2016, John Bellone <jbellone@bloomberg.net>
#
require 'poise_service/service_mixin'

module MumbleCookbook
  module Resource
    # A resource which manages the Mumble server service.
    # @since 1.0
    class MurmurService < Chef::Resource
      include Poise
      provides(:murmur_service)
      include PoiseService::ServiceMixin

      property(:user, kind_of: String, default: 'murmur')
      property(:group, kind_of: String, default: 'murmur')
      property(:directory, kind_of: String, default: '/var/lib/murmur')

      property(:version, kind_of: String, required: true)
      property(:binary_url, kind_of: String, required: true)
      property(:binary_checksum, kind_of: String)
      property(:config_file, kind_of: String, default: '/etc/murmur.ini')

      def command
        ['/opt/murmur/current/murmur.x86', ['-ini', config_file]].flatten.join(' ')
      end
    end
  end

  module Provider
    # A provider which installs the Mumble server service.
    # @since 1.0
    class MurmurService < Chef::Provider
      include Poise
      provides(:murmur_service)
      include PoiseService::ServiceMixin

      def action_enable
        notifying_block do
          directory new_resource.directory do
            recursive true
            owner new_resource.user
            group new_resource.group
            mode '0755'
          end

          libartifact_file 'murmur' do
            install_path '/opt'
            artifact_version new_resource.version
            remote_url new_resource.binary_url % { version: new_resource.version }
            remote_checksum new_resource.binary_checksum
          end
        end
        super
      end

      private
      def service_options(service)
        service.command(new_resource.command)
        service.user(new_resource.user)
        service.directory(new_resource.directory)
      end
    end
  end
end
