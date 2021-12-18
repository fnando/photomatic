# frozen_string_literal: true

require "test_helper"

class LoginLinkTest < ActiveSupport::TestCase
  test "creates a valid login url" do
    login_url = LoginLink.create!("john@example.com")
    assert LoginLink.valid?(login_url)
  end

  test "rejects expired urls" do
    login_url = LoginLink.create!("john@example.com")

    AuthCode.last.update(expires_at: 10.minutes.ago)

    refute LoginLink.valid?(login_url)
  end

  test "rejects code already used" do
    login_url = LoginLink.create!("john@example.com")

    assert LoginLink.valid?(login_url)
    refute LoginLink.valid?(login_url)
  end

  test "rejects tempered urls" do
    login_url = LoginLink.create!("john@example.com")
    AuthCode.last.update(expires_at: 10.minutes.ago)
    login_url.gsub!(/email=([^&]+)/, "email=tempered")

    refute LoginLink.valid?(login_url)
  end
end
