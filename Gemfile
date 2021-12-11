# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.0.alpha2"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails", ">= 0.3.4"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails", ">= 0.7.11"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails", ">= 0.4.0"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Access environment variables. Also includes presence validation,
# type coercion and default values.
gem "superconfig"

gem "ar-bigint"
gem "ar-timestamptz"
gem "ar-uuid"
gem "attr_keyring"
gem "defaults"
gem "dotenv"
gem "haikunate"
gem "human_routes"
gem "rails-env"
gem "signal"
gem "url_signature"

group :development, :test do
  gem "pry-meta"
end

group :development do
  gem "rubocop"
  gem "rubocop-fnando"
  gem "rubocop-performance"
  gem "rubocop-rails"
end

group :test do
  gem "capybara"
  gem "minitest-utils"
  gem "selenium-webdriver"
  gem "webdrivers"
end
