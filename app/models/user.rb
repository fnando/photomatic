# frozen_string_literal: true

class User < ApplicationRecord
  attr_keyring Photomatic::Config.user_keyring,
               digest_salt: Photomatic::Config.user_digest_salt
  attr_encrypt :email

  defaults username: lambda {
                       Haiku.next do |new_username|
                         User.exists?(username: new_username)
                       end
                     }
  has_many :posts, dependent: :restrict_with_exception
  has_many :likes, dependent: :nullify

  def to_param
    username
  end
end
