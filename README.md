# Capifig

Deploy different configuration per stage with Capistrano (with the multi-stage extension).

The 0.0.x releases of this gem are unstable, and the API/usage may change significantly, even in minor version
increments.

## Installation

Add this line to your application's Gemfile:

    gem 'capifig'

Add the following line to your Capistrano deploy.rb:

    require 'capifig/capistrano'

## Usage

For each stage, create a folder in `config/deploy/<stage>`, containing all the config files specific to that
stage. On deployment (after deploy:update_code), these files will be copied to your app's root. Subfolders may be used,
but must already exist on the server. For example, if you have a folder `config/deploy/production/dbconfig`, you
also need a folder `dbconfig` in the root of your app.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
