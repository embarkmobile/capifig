# Capifig

Deploy different configuration per stage with Capistrano (with the multi-stage extension).

The 0.x releases of this gem are unstable, and the API/usage may change significantly, even in minor version
increments.

## Installation

Add this line to your application's Gemfile:

    gem 'capifig'

### Capistrano 3

Add the following line to your Capistrano Capfile:

    require 'capifig/capistrano3'

### Capistrano 2

Add the following line to your Capistrano `config/deploy.rb`:

    require 'capifig/capistrano'

## Usage

For each stage, create a folder in `config/deploy/<stage>`, containing all the config files specific to that
stage. On deployment (after deploy:update_code), these files will be copied to your app's root. Subfolders may be used,
but must already exist on the server. For example, if you have a folder `config/deploy/production/dbconfig`, you
also need a folder `dbconfig` in the root of your app.
