# frozen_string_literal: true

require_relative "test_helper"
require "active_job"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1920, 1080]

  include I18nTestHelpers
  include ApplicationSystemTestHelpers

  setup do
    Capybara.server_port = ActionMailer::Base.default_url_options[:port]
  end
end
