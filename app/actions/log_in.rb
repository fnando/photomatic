# frozen_string_literal: true

class LogIn
  include Voltage.call

  attr_reader :form

  def initialize(form)
    @form = form
  end

  def call
    return emit(:error) unless form.valid?

    login_link = LoginLink.create!(form.email)

    encrypted_email = Encryptor.encrypt(form.email, purpose: :login)
    encrypted_login_link = Encryptor.encrypt(login_link, purpose: :login)

    AuthMailer.login(encrypted_email, encrypted_login_link).deliver_later

    emit(:success)
  end
end
