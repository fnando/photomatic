# frozen_string_literal: true

module Lens
  Config = SuperConfig.new do
    mandatory :database_url, string
    mandatory :tz, string
    credential :encryptor_secret
    credential :auth_code_keyring
    credential :auth_code_digest_salt
    credential :user_keyring
    credential :user_digest_salt
    credential :signed_url_secret
    optional :app_host, string, "example.com"
  end
end
