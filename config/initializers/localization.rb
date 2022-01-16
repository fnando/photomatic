# frozen_string_literal: true

Rails.env.on(:any) do
  config.time_zone = Photomatic::Config.tz
end

I18n.available_locales = %i[en pt-BR]
I18n.default_locale = :en
I18n.locale = :en
