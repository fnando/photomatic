# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"

# Full-stack web application framework.
# [https://rubyonrails.org]
gem "rails", "~> 7.0.0"

# Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/]
# [https://github.com/ged/ruby-pg]
gem "pg"

# Puma is a simple, fast, threaded, and highly parallel HTTP 1.1 server for
# Ruby/Rack applications
# [https://puma.io]
gem "puma"

# Sprockets Rails integration
# [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use ESM with importmap to manage modern JavaScript in Rails without
# transpiling or bundling.
# [https://github.com/rails/importmap-rails]
gem "importmap-rails", ">= 0.3.4"

# Bundle and transpile JavaScript in Rails with esbuild, rollup.js, or Webpack.
# [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

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

# A different take on using ActionMailer, Markdown and I18n.
# [https://github.com/fnando/actionmailer-markdown]
gem "actionmailer-markdown"

# Export i18n translations and use them on JavaScript.
# [https://github.com/fnando/i18n-js]
gem "i18n-js", "~> 4.0.0.alpha1"

# Do some browser detection with Ruby.
# [https://github.com/fnando/browser]
gem "browser"

# Simple Mail Transfer Protocol client library for Ruby.
# [https://github.com/ruby/net-smtp]
gem "net-smtp"

# AWS SDK for Ruby - Amazon S3
# [https://github.com/aws/aws-sdk-ruby]
gem "aws-sdk-s3", require: false

# High-level wrapper for processing images for the web with ImageMagick or
# libvips.
# [https://github.com/janko/image_processing]
gem "image_processing"

# ActiveStorage blob validator.
# [https://github.com/aki77/activestorage-validator]
gem "activestorage-validator"

# Easily define <meta> and <link> tags. I18n support for descriptions, keywords
# and titles.
# [https://github.com/fnando/page_meta]
gem "page_meta"

# Forms made easy!
# [https://github.com/heartcombo/simple_form]
gem "simple_form"

# Simple, efficient background processing for Ruby
# [https://sidekiq.org]
gem "sidekiq"

# Color is a Ruby library to provide basic RGB, CMYK, HSL, and other colourspace
# manipulation support to applications that require it
# [https://github.com/halostatue/color]
gem "color"

# Calculate rgb color distances using CIEDE2000 formula
# [https://github.com/hansondr/color_diff]
gem "color_diff"

# Add some nice ActiveModel/ActiveRecord validators.
# [http://rubygems.org/gems/validators]
gem "validators"

# Extract root domain from hosts (e.g. www.example will be extracted as
# example.com). It normalizes punycode domains and considers second-level domain
# names.
# [https://github.com/fnando/root_domain]
gem "root_domain"

# A simple HTTP client
# [http://rubygems.org/gems/aitch]
gem "aitch"

# Sidekiq::Clockwork is a simplistic implementation of a job scheduler based on
# Clockwork, but without having to run a separated process.
# [https://github.com/fnando/sidekiq-clockwork]
gem "sidekiq-clockwork"

# Find email provider service based on the email address.
# [https://github.com/fnando/email-provider-info]
gem "email-provider-info"

# A simple wrapper for objects in less than 100 lines.
# [http://github.com/fnando/burgundy]
gem "burgundy"

group :development, :test do
  # Meta package that requires several pry extensions.
  gem "pry-meta"

  # Security vulnerability scanner for Ruby on Rails.
  # [https://brakemanscanner.org]
  gem "brakeman"
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

  # Process manager for applications with multiple components
  # [http://github.com/ddollar/foreman]
  gem "foreman"

  # Create SVG sprites using SVG links.
  # [https://github.com/fnando/svg_sprite]
  gem "svg_sprite"
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

  # factory_bot provides a framework and DSL for defining and using model
  # instance factories.
  # [https://github.com/thoughtbot/factory_bot]
  gem "factory_bot"

  # Preload factories (Factory Bot) just like fixtures. It will be easier and,
  # probably, faster!
  # [http://rubygems.org/gems/factory_bot-preload]
  gem "factory_bot-preload", require: false

  # Library for stubbing HTTP requests in Ruby.
  # [http://github.com/bblimke/webmock]
  gem "webmock"

  # Mocking and stubbing library
  # [https://mocha.jamesmead.org]
  gem "mocha"
end
