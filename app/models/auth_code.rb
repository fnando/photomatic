# frozen_string_literal: true

class AuthCode < ApplicationRecord
  defaults code: -> { Haiku.call(variant: -> { SecureRandom.hex(5) }) },
           expires_at: -> { 5.minutes.from_now }

  attr_keyring Lens::Config.auth_code_keyring,
               digest_salt: Lens::Config.auth_code_digest_salt
  attr_encrypt :code
end
