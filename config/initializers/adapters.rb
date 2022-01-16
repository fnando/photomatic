# frozen_string_literal: true

Rails.application.config.after_initialize do
  Rails.env.on(:development) do
    GeoLocation.adapter = GeoLocation::Development
  end
end
