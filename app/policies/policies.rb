# frozen_string_literal: true

module Policies
  def can_access_post?(user:, post:)
    CanAccessPost.call(user: user, post: post)
  end
end
