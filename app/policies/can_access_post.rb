# frozen_string_literal: true

class CanAccessPost
  VISIBLE = %w[unlisted public].freeze

  def self.call(user:, post:)
    [
      post.user_id == user&.id,
      VISIBLE.include?(post.visibility)
    ].any?
  end
end
