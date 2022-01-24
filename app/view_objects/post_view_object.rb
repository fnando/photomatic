# frozen_string_literal: true

class PostViewObject < Burgundy::Item
  def photo_width
    item.meta["exif"].fetch("width")
  end

  def photo_height
    item.meta["exif"].fetch("height")
  end

  def aspect_ratio
    Rational(photo_width, photo_height).to_s
  end

  def camera
    [
      item.meta["exif"]["make"],
      item.meta["exif"]["model"]
    ].compact.join(" ")
  end

  def lens
    [
      item.meta["exif"]["lens_make"],
      item.meta["exif"]["lens"]
    ].compact.join(" ").gsub(%r{f/}i, "ƒ/")
  end

  def fstop
    return unless item.meta["exif"]["fstop"]

    "ƒ/#{item.meta['exif']['fstop']}"
  end

  def iso
    return unless item.meta["exif"]["iso"]

    "ISO #{item.meta['exif']['iso']}"
  end

  def photo_taken_at
    return unless item.meta["exif"]["taken_at"]
  end

  def shutter_speed
    return unless item.meta["exif"]["shutter_speed"]

    "#{item.meta['exif']['shutter_speed']}s"
  end

  def technical_info
    [
      item.meta["exif"]["focal_length"],
      fstop,
      shutter_speed,
      iso
    ].compact.join(", ")
  end

  def has?(attribute)
    public_send(attribute).present?
  end
end
