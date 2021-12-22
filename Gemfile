# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

# Full-stack web application framework.
# [https://rubyonrails.org]
gem "rails", "~> 7.0.0"

# Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/]
# [https://github.com/ged/ruby-pg]
gem "pg", "~> 1.1"

# Puma is a simple, fast, threaded, and highly parallel HTTP 1.1 server for
# Ruby/Rack applications
# [https://puma.io]
gem "puma", "~> 5.0"

# Use ESM with importmap to manage modern JavaScript in Rails without
# transpiling or bundling.
# [https://github.com/rails/importmap-rails]
gem "importmap-rails", ">= 0.3.4"

# The speed of a single-page web application without having to write any
# JavaScript.
# [https://github.com/hotwired/turbo-rails]
gem "turbo-rails", ">= 0.7.11"

# A modest JavaScript framework for the HTML you already have.
# [https://stimulus.hotwired.dev]
gem "stimulus-rails", ">= 0.4.0"

# Use Active Model has_secure_password
# [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Access environment variables. Also includes presence validation, type coercion
# and default values.
# [https://github.com/fnando/superconfig]
gem "superconfig"

# Make ActiveRecord's PostgreSQL adapter always use bigint columns
# [https://rubygems.org/gems/ar-bigint]
gem "ar-bigint"

# Make ActiveRecord's PostgreSQL adapter use timestamptz as datetime columns
# [https://rubygems.org/gems/ar-timestamptz]
gem "ar-timestamptz"

# Override migration methods to support UUID columns without having to be
# explicit about it.
# [http://rubygems.org/gems/ar-uuid]
gem "ar-uuid"

# Simple encryption-at-rest plugin for ActiveRecord.
# [https://github.com/fnando/attr_keyring]
gem "attr_keyring"

# Set default values for ActiveRecord attributes
# [http://rubygems.org/gems/defaults]
gem "defaults"

# Loads environment variables from `.env`.
# [https://github.com/bkeepers/dotenv]
gem "dotenv"

# Generate Heroku-like memorable random names like adorable-ox-1234.
# [https://github.com/fnando/haikunate]
gem "haikunate"

# I say no to REST for client-facing urls.
# [https://github.com/fnando/human_routes]
gem "human_routes"

# Avoid environment detection on Rails
# [https://github.com/fnando/rails_env]
gem "rails-env"

# A simple observer implementation for POROs (Plain Old Ruby Object) and
# ActiveRecord objects.
# [http://github.com/fnando/voltage]
gem "voltage"

# A simple authentication system for Rails apps
# [http://rubygems.org/gems/simple_auth]
gem "simple_auth"

# Create and verify signed urls. Supports expiration time.
# [https://github.com/fnando/url_signature]
gem "url_signature"

group :development, :test do
  # Meta package that requires several pry extensions.
  gem "pry-meta"
end

group :development do
  # Automatic Ruby code style checking tool.
  # [https://github.com/rubocop/rubocop]
  gem "rubocop"

  # Rubocop configuration
  # [https://github.com/fnando/rubocop-fnando]
  gem "rubocop-fnando"

  # Automatic performance checking tool for Ruby code.
  # [https://github.com/rubocop/rubocop-performance]
  gem "rubocop-performance"

  # Automatic Rails code style checking tool.
  # [https://github.com/rubocop/rubocop-rails]
  gem "rubocop-rails"
end

group :test do
  # Capybara aims to simplify the process of integration testing Rack
  # applications, such as Rails, Sinatra or Merb
  # [https://github.com/teamcapybara/capybara]
  gem "capybara"

  # Some utilities for your Minitest day-to-day usage.
  # [http://github.com/fnando/minitest-utils]
  gem "minitest-utils"

  # Selenium is a browser automation tool for automated testing of webapps and
  # more
  # [https://selenium.dev]
  gem "selenium-webdriver"

  # Easy download and use of browser drivers.
  # [https://github.com/titusfortner/webdrivers]
  gem "webdrivers"
end
