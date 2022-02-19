# frozen_string_literal: true

module Analytics
  def self.signup(user_id)
    Rails.logger.debug { "[analytics] user has signed up (#{user_id})" }
  end

  def self.login(user_id)
    Rails.logger.debug { "[analytics] user has logged in (#{user_id})" }
  end
end
