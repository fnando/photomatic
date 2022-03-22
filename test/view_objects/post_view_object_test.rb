# frozen_string_literal: true

require "test_helper"

class PostViewObjectTest < ActiveSupport::TestCase
  test "returns attributes" do
    view_object = PostViewObject.new(create(:post, :exif))

    assert_equal 4032, view_object.photo_width
    assert_equal 3024, view_object.photo_height
    assert_equal "4/3", view_object.aspect_ratio
    assert_equal "Apple iPhone 12 mini", view_object.camera
    assert_equal "Apple iPhone 12 mini back dual wide camera 4.2mm ƒ/1.6",
                 view_object.lens
    assert_equal "ƒ/1.6", view_object.fstop
    assert_equal "ISO 32", view_object.iso
    assert_equal "Tue, 24 Aug 2021 15:41:04 +0000", view_object.photo_taken_at
    assert_equal "1/5814s", view_object.shutter_speed
    assert_equal "26mm, ƒ/1.6, 1/5814s, ISO 32", view_object.technical_info
  end

  test "detects attribute presence" do
    view_object = PostViewObject.new(create(:post, :exif))
    view_object.item.meta["exif"].delete("shutter_speed")

    assert view_object.has?(:photo_width)
    refute view_object.has?(:shutter_speed)
  end
end
