# frozen_string_literal: true

require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "returns page_id" do
    controller.stubs(:action_name).returns("some_action")

    assert_equal "test-some_action", page_id
  end

  test "returns icon" do
    expected =
      %[<svg class="icon icon--heart"><use href="#icon--heart"></use></svg>]

    assert_html expected, icon(:heart)

    expected =
      %[<svg class="icon icon--heart lg"><use href="#icon--heart"></use></svg>]

    assert_html expected, icon(:heart, class: "icon icon--heart lg")
  end

  test "returns gravatar" do
    url = "https://gravatar.com/avatar/75056d1f982b7724d0f7ab08ef84e4a6?s=100"
    assert_html %[<img class="avatar" src="#{url}" />],
                gravatar("john@photomatic.app")

    url = "https://gravatar.com/avatar/75056d1f982b7724d0f7ab08ef84e4a6?s=200"
    assert_html %[<img class="avatar" src="#{url}" />],
                gravatar("john@photomatic.app", size: 100)

    url = "https://gravatar.com/avatar/75056d1f982b7724d0f7ab08ef84e4a6?s=100"
    assert_html %[<img class="avatar" id="photo" src="#{url}" />],
                gravatar("john@photomatic.app", id: "photo")
  end

  test "returns post location" do
    post = Post.new(city: "Vancouver", region: "BC", country: "CAN")
    assert_equal "Vancouver, BC, Canada", post_location(post)
  end

  test "returns like button" do
    stubs(:current_user).returns(users(:default))

    expected = <<~HTML
      <button type="button" data-controller="like-button" data-action="click->like-button#handleClick" data-liked="false" data-post-id="524ec833-1c81-4d94-9952-5bb347f08672"><svg class="icon icon--heart_outline"><use href="#icon--heart_outline"></use></svg><svg class="icon icon--heart"><use href="#icon--heart"></use></svg></button>
    HTML

    assert_html expected, like_button(posts(:default))
  end
end
