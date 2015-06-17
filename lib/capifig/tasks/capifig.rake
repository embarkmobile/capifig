
namespace :capifig do
  def remote_path(release_path, config_path, file)
    path = Pathname.new(release_path) + relative_path(config_path, file)
    path.to_s
  end

# Given a local path, returns the relative path to the file
  def relative_path(config_path, file)
    path = Pathname.new(file).relative_path_from(Pathname.new(config_path)).to_s
    # For security reasons, we check that the path does not contain any ..'s
    raise ArgumentError, "File '#{file}' is not in '#{config_path}'" if path.include? '..'
    path
  end


  desc <<-DESC
            Deploy configuration files.
  DESC
  task :deploy do
    on roles(:app) do
      stage = fetch(:stage, 'production')
      config_path = fetch(:config_path, "config/deploy/#{stage}")
      files = `git ls-files #{config_path}`.split($/)
      files.sort!
      files.each do |f|
        info "Uploading #{f}"
        upload! f, remote_path(release_path, config_path, f)
      end
    end
  end

  before 'deploy:updated', 'capifig:deploy'
end
