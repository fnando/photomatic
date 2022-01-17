# frozen_string_literal: true

require_relative "../config/environment"

# Related urls:
# https://github.com/umpirsky/country-list
# http://country.io/

country_codes = Aitch.get!("http://country.io/iso3.json").data

I18n.available_locales.each do |locale|
  underscored_locale = locale.to_s.tr("-", "_")
  country_names = JSON.parse(Aitch.get!("https://raw.githubusercontent.com/umpirsky/country-list/master/data/#{underscored_locale}/country.json").data)

  country_names =
    country_names.each_with_object({}) do |(code_alpha2, name), buffer|
      code_alpha3 = country_codes[code_alpha2]
      buffer[code_alpha3] = name
    end

  output_path = Rails.root.join("config/locales/#{locale}/countries.yml")
  FileUtils.mkdir_p(output_path.dirname)

  File.open(output_path, "w") do |io|
    io << YAML.dump(locale => {countries: country_names})
  end
end
