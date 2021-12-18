# frozen_string_literal: true

require "test_helper"

class AuthCodeTest < ActiveSupport::TestCase
  test "detects expired code" do
    expires_at = 1.second.ago
    auth_code = AuthCode.new(expires_at: expires_at)

    assert auth_code.expired?
  end

  test "detects fresh code" do
    expires_at = 1.minute.from_now
    auth_code = AuthCode.new(expires_at: expires_at)

    refute auth_code.expired?
  end
end
