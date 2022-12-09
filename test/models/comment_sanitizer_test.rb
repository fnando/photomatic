# frozen_string_literal: true

require "test_helper"

class CommentSanitizerTest < ActiveSupport::TestCase
  test "scrubs text" do
    actual = %[check this out: <a href="http://example.com">spam</a>]
    expected = "check this out: "

    assert_equal expected, CommentSanitizer.call(actual)
  end
end
