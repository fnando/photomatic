# frozen_string_literal: true

class CommentPost
  include Voltage.call
  include Policies

  attr_accessor :user, :post_id, :text

  def initialize(user:, post_id:, text:)
    @user = user
    @post_id = post_id
    @text = text
  end

  def post
    @post ||= Post.find_by(id: post_id)
  end

  def call
    return emit(:unauthorized) unless can_access_post?(user:, post:)

    comment = post.comments.create!(
      user:,
      text:,
      tagged_user_ids: UsernameExtractor.call(text)
    )

    emit(:success, comment)
  end
end
