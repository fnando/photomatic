# frozen_string_literal: true

require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "generates text digest" do
    comment = Comment.new

    comment.text = "hello"
    assert_equal "5d41402abc4b2a76b9719d911017c592", comment.text_digest

    comment.text = "goodbye"
    assert_equal "69faab6268350295550de7d587bc323d", comment.text_digest

    comment.text = "  goodbye \n"
    assert_equal "69faab6268350295550de7d587bc323d", comment.text_digest

    comment.text = nil
    assert_equal "d41d8cd98f00b204e9800998ecf8427e", comment.text_digest
  end
end
