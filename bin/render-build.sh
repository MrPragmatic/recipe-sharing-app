#!/usr/bin/env bash
# exit on error
# Build file for Render.com deployment, reference: https://render.com/docs/deploy-rails
# Set the option to exit on any error during script execution
set -o errexit
# Install Ruby gems specified in the Gemfile using Bundler
bundle install
# Precompile the assets of the Rails application
bundle exec rake assets:precompile
# Clean up previously generated assets
bundle exec rake assets:clean
# Run database migrations to apply any pending changes
bundle exec rake db:migrate