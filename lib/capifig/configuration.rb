require 'pathname'

module Capifig
  class Configuration
    def self.deploy configuration, path
      Configuration.new(configuration, path).deploy
    end

    attr_accessor :path
    attr_accessor :cap

    def initialize(configuration, path)
      @cap = configuration
      @path = path
    end

    # Returns an array of local paths of files to upload
    def files
      # Alternative: this glob also works, but may include temporary files:
      #files = Dir.glob("#@path/**/*", File::FNM_DOTMATCH).select { |f| File.file?(f) }
      files = `git ls-files #@path`.split($/)
      files.sort
    end

    # Given a local path, returns the remote path for the file
    def remote_path(file)
      path = Pathname.new(cap.fetch(:release_path)) + relative_path(file)
      path.to_s
    end

    # Given a local path, returns the relative path to the file
    def relative_path(file)
      path = Pathname.new(file).relative_path_from(Pathname.new(@path)).to_s
      # For security reasons, we check that the path does not contain any ..'s
      raise ArgumentError, "File '#{file}' is not in '#@path'" if path.include? '..'
      path
    end

    def deploy
      files.each do |f|
        cap.upload(f, remote_path(f))
      end

    end
  end
end
