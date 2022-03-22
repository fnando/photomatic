# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
  add_filter "/config/"
  add_filter "/test/"
  add_filter "/jobs/"
  add_filter "/db/"

  Dir["./app/*"].each do |dir|
    next if ["./app/jobs"].include?(dir)
    next if Dir["#{dir}/**/*.rb"].empty?

    add_group File.basename(dir).titleize, dir[2..-1]
  end

  add_group "Library", "lib"

  track_files "{app,lib}/**/*.rb"
end

ENV["RAILS_ENV"] = "test"
require_relative "../config/environment"
require "rails/test_help"
require "factory_bot/preload"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    # parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical
    # order.
    # fixtures :all

    # Add more helper methods to be used by all tests here...

    self.use_instantiated_fixtures = true
  end
end

Dir["#{__dir__}/support/**/*.rb"].each do |file|
  require file
end

FactoryBot::Preload.minitest
