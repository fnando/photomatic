# frozen_string_literal: true

class LoginForm
  include ActiveModel::Model

  attr_accessor :email

  validates_presence_of :email
end
