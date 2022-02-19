# frozen_string_literal: true

class VerifyEmail
  include Voltage.call

  attr_reader :signed_url, :code, :email

  def initialize(signed_url:, code:, email:)
    @signed_url = signed_url
    @code = code
    @email = email
  end

  def call
    return emit(:error) unless LoginLink.valid?(signed_url)

    type = :login

    user = User.find_or_create_by!(
      email_digest: User.keyring.digest(email)
    ) do |record|
      type = :signup
      record.display_name = ""
      record.email = email
    end

    Analytics.send(type, user.id)

    emit(:success, user)
  end
end
