# frozen_string_literal: true

class LoginForm < Form
  attribute :email

  validates_presence_of :email
end
