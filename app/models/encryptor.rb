# frozen_string_literal: true

class Encryptor
  def self.encryptor
    ActiveSupport::MessageEncryptor.new(
      Base64.decode64(Photomatic::Config.encryptor_secret)
    )
  end

  def self.encrypt(unencrypted_message, expires_in: nil, purpose: nil)
    encryptor.encrypt_and_sign(
      unencrypted_message,
      expires_in:,
      purpose:
    )
  end

  def self.decrypt(encrypted_message, purpose: nil)
    encryptor.decrypt_and_verify(
      encrypted_message,
      purpose:
    )
  rescue ActiveSupport::MessageEncryptor::InvalidMessage
    nil
  end
end
