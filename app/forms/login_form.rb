# frozen_string_literal: true

class LoginForm < Form
  attribute :email

  validates_presence_of :email
  validates_email_format_of :email
end
