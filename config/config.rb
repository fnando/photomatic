# frozen_string_literal: true

module Lens
  Config = SuperConfig.new do
    mandatory :database_url, string
    mandatory :tz, string
    credential :encryptor_secret
    credential :signed_url_secret
    optional :app_host, string, "example.com"
  end
end
