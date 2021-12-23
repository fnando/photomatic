# frozen_string_literal: true

require "test_helper"

class AuthMailerTest < ActionMailer::TestCase
  test "login" do
    encrypted_email = Encryptor.encrypt("john@photomatic.app", purpose: :login)
    encrypted_url = Encryptor.encrypt(
      "https://example.com/login-url",
      purpose: :login
    )
    mail = AuthMailer.login(encrypted_email, encrypted_url)

    assert_equal t("auth_mailer.login.subject"), mail.subject
    assert_equal ["john@photomatic.app"], mail.to
    assert_equal ["hi@example.com"], mail.from
    assert_match "https://example.com/login-url", mail.body.encoded
  end
end
