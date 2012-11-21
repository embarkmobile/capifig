# Defines capifig:deploy which deploys configuration
require 'capistrano'
require 'capifig/configuration'

module Capifig
  module Capistrano
    def self.load_into(configuration)
      configuration.load do
        after "deploy:update_code", "capifig:deploy"

        namespace :capifig do
          desc <<-DESC
            Deploy configuration files.
          DESC
          task :deploy do
            stage = fetch(:stage, 'production')
            config_path = fetch(:config_path, "config/deploy/#{stage}")
            Capifig::Configuration.deploy(configuration, config_path)
            logger.info "Configuration deployment complete."
          end
        end
      end
    end
  end
end

if Capistrano::Configuration.instance
  # Automatically load configuration into capistrano, if capistrano is being configured
  Capifig::Capistrano.load_into(Capistrano::Configuration.instance)
end