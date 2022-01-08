# frozen_string_literal: true

require "test_helper"

class ProcessImageTest < ActiveSupport::TestCase
  let(:post) do
    post = build(:post, user: users(:john))
    post.photo.attach(filename: "beach.jpg",
                      io: File.open("./test/fixtures/files/beach.jpg"))
    post.tap(&:save!)
  end

  test "export images" do
    ProcessImage.call(post.id)
    post.reload

    assert post.thumbnail.attached?
    assert post.large.attached?
  end
end
