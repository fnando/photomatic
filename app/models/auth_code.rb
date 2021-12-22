# frozen_string_literal: true

class AuthCode < ApplicationRecord
  defaults code: -> { Haiku.call(variant: -> { SecureRandom.hex(5) }) },
           expires_at:
            -> { Photomatic::Config.email_verification_ttl.minutes.from_now }

  attr_keyring Photomatic::Config.auth_code_keyring,
               digest_salt: Photomatic::Config.auth_code_digest_salt
  attr_encrypt :code

  def expired?
    Time.now.to_i > expires_at.to_i
  end
end
