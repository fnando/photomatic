# frozen_string_literal: true

class AuthCode < ApplicationRecord
  encrypts :code, deterministic: true

  defaults code: -> { Haiku.call(variant: -> { SecureRandom.hex(5) }) },
           expires_at: -> { 5.minutes.from_now }
end
