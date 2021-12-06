# frozen_string_literal: true

class User < ApplicationRecord
  encrypts :email, deterministic: true, downcase: true
end
