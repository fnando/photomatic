# frozen_string_literal: true

require "test_helper"

class ViewPostTest < ActiveSupport::TestCase
  test "emits unauthorized when post cannot be viewed by user" do
    unauthorized = Callable.new
    success = Callable.new

    ViewPost.call(nil, posts(:default).id) do |action|
      action.on(:unauthorized, &unauthorized)
      action.on(:success, &success)
    end

    assert unauthorized.called?
    refute success.called?
  end

  test "emits success when post can be viewed by user" do
    unauthorized = Callable.new
    success = Callable.new

    ViewPost.call(users(:john), posts(:default).id) do |action|
      action.on(:unauthorized, &unauthorized)
      action.on(:success, &success)
    end

    refute unauthorized.called?
    assert success.called_exactly?(1)
    assert_equal [posts(:default)], success.calls.first
  end
end
