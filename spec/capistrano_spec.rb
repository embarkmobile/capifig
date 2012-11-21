require 'spec_helper'
require 'capifig/capistrano'
require 'capifig/configuration'

describe Capifig::Capistrano do
  let(:cap) do
    cap = Capistrano::Configuration.new
    Capifig::Capistrano.load_into cap
    cap.dry_run = true
    cap
  end

  it "should define capifig:deploy" do
    cap.find_task('capifig:deploy').should be
  end

  it "should deploy config files on capifig:deploy" do
    Capifig::Configuration.should_receive(:deploy).with(cap, 'config/deploy/stages/production')

    cap.find_and_execute_task('capifig:deploy')
  end

  it "should should get config path from the current stage" do
    cap.set(:stage, 'test-stage')
    Capifig::Configuration.should_receive(:deploy).with(cap, 'config/deploy/stages/test-stage')

    cap.find_and_execute_task('capifig:deploy')
  end

  it "should should allow overriding of the config path" do
    cap.set(:stage, 'test-stage')
    cap.set(:config_path, 'my/config/path')
    Capifig::Configuration.should_receive(:deploy).with(cap, 'my/config/path')

    cap.find_and_execute_task('capifig:deploy')
  end
end
