# frozen_string_literal: true

Rails.env.on(:development, :production) do
  Rails.application.routes.default_url_options = {
    host: Photomatic::Config.app_host,
    protocol: Photomatic::Config.force_ssl? ? :https : :http
  }

  config.action_mailer.default_url_options =
    Rails.application.routes.default_url_options
end

Rails.env.on(:test) do
  Rails.application.routes.default_url_options = {
    host: "localhost",
    protocol: :http,
    port: 12_121
  }

  config.action_mailer.default_url_options =
    Rails.application.routes.default_url_options
end
