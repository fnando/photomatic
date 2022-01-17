# frozen_string_literal: true

Rails.application.config.after_initialize do
  Rails.env.on(:development, :test) do
    GeoLocation.adapter = GeoLocation::Development
  end
end
