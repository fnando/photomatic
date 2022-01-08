# frozen_string_literal: true

module Photomatic
  Config = SuperConfig.new do
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
    optional :tz, string, "Etc/UTC"
    optional :photo_mime_types,
             array(string),
             %w[image/png image/jpeg image/heic image/heif image/webp]

    optional :aws_upload_access_key_id, string, "sample-value"
    optional :aws_upload_secret_access_key_id, string, "sample-value"
    optional :aws_upload_bucket, string, "sample-value"
    optional :aws_upload_region, string, "sample-value"
  end
end
