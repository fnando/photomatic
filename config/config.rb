# frozen_string_literal: true

module Photomatic
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
    optional :force_ssl, bool, true
    optional :default_email_sender, string, "hi@example.com"
    optional :email_verification_ttl, int, 10.minutes
  end
end
