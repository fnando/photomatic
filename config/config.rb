# frozen_string_literal: true

module Photomatic
  Config = SuperConfig.new(raise_exception: false) do
    credential :encryptor_secret
    credential :auth_code_keyring
    credential :auth_code_digest_salt
    credential :user_keyring
    credential :user_digest_salt
    credential :signed_url_secret
    credential :position_stack_api_key
    optional :app_host, string, "example.com"
    optional :force_ssl, bool, true
    optional :default_email_sender, string, "hi@example.com"
    optional :email_verification_ttl, int, 10.minutes
    optional :tz, string, "Etc/UTC"
    optional :photo_mime_types,
             array(string),
             %w[image/heic image/heif image/jpeg image/png image/webp]

    optional :aws_upload_access_key_id, string, "sample-value"
    optional :aws_upload_secret_access_key_id, string, "sample-value"
    optional :aws_upload_bucket, string, "sample-value"
    optional :aws_upload_region, string, "sample-value"
  end
end
