# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capifig/version'

Gem::Specification.new do |gem|
  gem.name          = "capifig"
  gem.version       = Capifig::VERSION
  gem.authors       = ["Ralf Kistner"]
  gem.email         = ["ralf@embarkmobile.com"]
  gem.description   = %q{Deploy different configuration per stage with Capistrano (with the multi-stage extension).}
  gem.summary       = %q{Deploy different configuration per stage with Capistrano.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'capistrano', '>= 2.0.0'
end
