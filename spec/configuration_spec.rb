require 'spec_helper'
require 'capifig/configuration'

describe Capifig::Configuration do
  let(:cap) do
    cap = Capistrano::Configuration.new
    cap.dry_run = true
    cap.set(:release_path, '/tmp/the/release')
    cap
  end

  let(:config) do
    Capifig::Configuration.new(cap, 'sample')
  end

  context "list files" do
    let(:expected) { %w(sample/.env sample/Procfile sample/config/database.yml) }

    after do
      FileUtils.rm_f 'sample/temp-file~'
    end

    it "should list files" do
      config.files.should == expected
    end

    it "should not list temporary files" do
      File.open('sample/temp-file~', 'w').close
      config.files.should == expected
    end
  end

  it "should make remote path" do
    config.relative_path('sample/config/database.yml').should == 'config/database.yml'
    config.remote_path('sample/config/database.yml').should == '/tmp/the/release/config/database.yml'
  end

  it "should not allow .. in paths" do
    -> { config.relative_path('config/database.yml') }.should raise_error(ArgumentError)
  end


  it "should deploy" do
    cap.should_receive(:upload).with('sample/.env', '/tmp/the/release/.env')
    cap.should_receive(:upload).with('sample/Procfile', '/tmp/the/release/Procfile')
    cap.should_receive(:upload).with('sample/config/database.yml', '/tmp/the/release/config/database.yml')
    Capifig::Configuration.deploy cap, 'sample'
  end

end
