# frozen_string_literal: true

require "test_helper"

class ExifTest < ActiveSupport::TestCase
  let(:exif) do
    Exif.call(JSON.parse(File.read("./test/fixtures/files/exif.json")).first)
  end

  test "returns exif" do
    taken_at = Time.zone.parse("2021-08-24 15:41:04")

    assert_equal 1.6, exif[:aperture]
    assert_equal "Off, Did not fire", exif[:flash]
    assert_equal "26mm", exif[:focal_length]
    assert_equal 1.6, exif[:fstop]
    assert_equal 3024, exif[:height]
    assert_equal 32, exif[:iso]
    assert_equal "+48.420269", exif[:latitude]
    assert_equal "-123.468719", exif[:longitude]
    assert_equal "1/5814", exif[:shutter_speed]
    assert_equal 4032, exif[:width]
    assert_equal "Apple", exif[:make]
    assert_equal "iPhone 12 mini back dual wide camera 4.2mm f/1.6", exif[:lens]
    assert_equal "iPhone 12 mini", exif[:model]
    assert_equal taken_at, exif[:taken_at]
  end
end
