# frozen_string_literal: true

class UnlikePost
  include Voltage.call
  include Policies

  attr_accessor :user, :post_id

  def initialize(user, post_id)
    @user = user
    @post_id = post_id
  end

  def post
    @post ||= Post.find_by(id: post_id)
  end

  def call
    return emit(:unauthorized) unless can_access_post?(user:, post:)

    like = post.likes.find_by(user_id: user.id)
    like.destroy!

    emit(:success)
  end
end
