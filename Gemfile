# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.2'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use PostgresSQL v. 16 as the database for Active Record
gem 'pg', '~> 1.5', '>= 1.5.4'

# Coffee rails adaptor
gem 'coffee-rails', '~> 5.0'

# Jquery to rails
gem 'jquery-rails', '~> 4.6'

# Javascript run-time
gem 'execjs', '~> 2.9', '>= 2.9.1'

# Cocooned gem for nested form
gem 'cocooned', '~> 2.0', '>= 2.0.3'

# Security audit gem
gem 'bundler-audit', '~> 0.9.1'

# Security vulnerability checker gem
gem 'brakeman', '~> 6.0', '>= 6.0.1'

# Rubocop code style checking gem
gem 'rubocop', '~> 1.57', '>= 1.57.2'

# Rubocop rails code style checking gem
gem 'rubocop-rails', '~> 2.22', '>= 2.22.2'

# Rubocop check for minitest (rails default)
gem 'rubocop-capybara', '~> 2.19'

# Use dotenv-rails to handle database access credentials
gem 'dotenv-rails'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 6.4'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end

gem 'tailwindcss-rails', '~> 2.0'
