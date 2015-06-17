require 'rspec'
require 'capifig'

include Capifig

RSpec.configure do |config|
  config.before :each do

  end

  # Use old syntax for now
  config.expect_with(:rspec) { |c| c.syntax = :should }
end
