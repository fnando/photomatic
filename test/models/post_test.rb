# frozen_string_literal: true

require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "is not liked when user is not defined" do
    refute posts(:default).liked_by?(nil)
  end

  test "is not liked when user didn't like post" do
    refute posts(:default).liked_by?(users(:default))
  end

  test "is liked when user liked post" do
    posts(:default).likes.create!(user: users(:default))

    assert posts(:default).liked_by?(users(:default))
  end
end
