# frozen_string_literal: true

require "test_helper"

class AuthMailerTest < ActionMailer::TestCase
  test "login" do
    encrypted_email = Encryptor.encrypt("john@35mm.com", purpose: :login)
    encrypted_url = Encryptor.encrypt(
      "https://example.com/login-url",
      purpose: :login
    )
    mail = AuthMailer.login(encrypted_email, encrypted_url)

    # TODO: Change subject
    assert_equal "Login", mail.subject
    assert_equal ["john@35mm.com"], mail.to
    assert_equal ["hi@example.com"], mail.from
    assert_match "https://example.com/login-url", mail.body.encoded
  end
end
