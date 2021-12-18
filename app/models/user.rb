# frozen_string_literal: true

class User < ApplicationRecord
  attr_keyring Lens::Config.user_keyring,
               digest_salt: Lens::Config.user_digest_salt
  attr_encrypt :email

  defaults username: lambda {
                       Haiku.next do |new_username|
                         User.exists?(username: new_username)
                       end
                     }
end
