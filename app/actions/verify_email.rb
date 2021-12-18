# frozen_string_literal: true

class VerifyEmail
  include Signal.call

  attr_reader :signed_url, :code, :email

  def initialize(signed_url:, code:, email:)
    @signed_url = signed_url
    @code = code
    @email = email
  end

  def call
    return emit(:error) unless LoginLink.valid?(signed_url)

    user = User.find_or_create_by!(
      email_digest: User.keyring.digest(email)
    ) do |record|
      record.email = email
    end

    emit(:success, user)
  end
end
