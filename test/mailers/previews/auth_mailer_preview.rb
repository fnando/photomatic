# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/auth_mailer
class AuthMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/auth_mailer/login
  def login
    encrypted_email = Encryptor.encrypt(
      "john@photomatic.app",
      expires_in: 5.minutes,
      purpose: :login
    )

    encrypted_login_link = Encryptor.encrypt(
      "https://some-login-link.com",
      expires_in: 5.minutes,
      purpose: :login
    )

    AuthMailer.login(encrypted_email, encrypted_login_link)
  end
end
