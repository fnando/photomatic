# frozen_string_literal: true

require "test_helper"

class CanAccessPostTest < ActiveSupport::TestCase
  test "is accessible by owner" do
    user = OpenStruct.new(id: 1234)
    post = OpenStruct.new(user_id: user.id, visibility: "private")

    assert CanAccessPost.call(user: user, post: post)
  end

  test "is accessible when post is public" do
    user = OpenStruct.new(id: 1234)
    post = OpenStruct.new(user_id: user.id, visibility: "public")

    assert CanAccessPost.call(user: user, post: post)
    assert CanAccessPost.call(user: nil, post: post)
  end

  test "is accessible when post is unlisted" do
    user = OpenStruct.new(id: 1234)
    post = OpenStruct.new(user_id: user.id, visibility: "unlisted")

    assert CanAccessPost.call(user: user, post: post)
    assert CanAccessPost.call(user: nil, post: post)
  end
end
