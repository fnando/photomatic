# frozen_string_literal: true

Rails.env.on(:any) do
  config.time_zone = Photomatic::Config.tz
end
