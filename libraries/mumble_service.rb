#
# Cookbook: mumble
# License: Apache 2.0
#
# Copyright 2016, John Bellone <jbellone@bloomberg.net>
#
require 'poise_service/service_mixin'

module MumbleCookbook
  module Resource
    # A resource which manages the Mumble server service.
    # @since 1.0
    class MumbleService < Chef::Resource
      include Poise
      provides(:mumble_service)
      include PoiseService::ServiceMixin

      property(:user, kind_of: String, default: 'mumble')
      property(:group, kind_of: String, default: 'mumble')
      property(:directory, kind_of: String, default: '/home/mumble')

      property(:version, kind_of: String, required: true)
      property(:install_method, equal_to: %w{binary package}, default: 'binary')
      property(:package_name, kind_of: String)
      property(:binary_url, kind_of: String)
      property(:binary_checksum, kind_of: String)
      property(:config_file, kind_of: String, default: '/etc/mumble/mumble.ini')

      def command
        [['-ini', config_file]].flatten.join(' ')
      end
    end
  end

  module Provider
    # A provider which installs the Mumble server service.
    # @since 1.0
    class MumbleService < Chef::Provider
      include Poise
      provides(:mumble_service)
      include PoiseService::ServiceMixin

      def action_enable
        notifying_block do
          package new_resource.package_name do
            version new_resource.version
            only_if { new_resource.install_method == 'package' }
          end

          libartifact_file 'mumble' do
            install_path '/opt'
            artifact_version new_resource.version
            remote_url new_resource.binary_url % { version: new_resource.version  }
            remote_checksum new_resource.binary_checksum
            only_if { new_resource.install_method == 'binary' }
          end
        end
        super
      end

      private
      def service_options(service)
        service.command(new_resource.command)
        service.environment(PATH: '/usr/local/bin:/usr/bin')
        service.user(new_resource.user)
        service.directory(new_resource.directory)
      end
    end
  end
end
