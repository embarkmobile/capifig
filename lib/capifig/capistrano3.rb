# Defines capifig:deploy which deploys configuration
require 'capistrano'
load File.expand_path("../tasks/capifig.rake", __FILE__)
