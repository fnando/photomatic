# frozen_string_literal: true

Rails.env.on(:test, :production) do
  Rails.application.routes.default_url_options = {
    host: Lens::Config.app_host,
    protocol: :https
  }
end
