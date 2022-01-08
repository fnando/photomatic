# frozen_string_literal: true

class Exif
  ATTRIBUTES = {
    "DateTimeOriginal" => :taken_at,
    "Make" => :make,
    "LensID" => :lens,
    "Model" => :model,
    "ImageWidth" => :width,
    "ImageHeight" => :height,
    "Aperture" => :aperture,
    "GPSLatitude" => :latitude,
    "GPSLongitude" => :longitude,
    "ShutterSpeed" => :shutter_speed,
    "Flash" => :flash,
    "ISO" => :iso,
    "FNumber" => :fstop,
    "FocalLengthIn35mmFormat" => :focal_length
  }.freeze

  def self.call(payload)
    ATTRIBUTES.each_with_object({}) do |(from, to), buffer|
      buffer[to] = process_value(to, payload[from])
    end
  end

  def self.process_value(key, value)
    case key
    when :taken_at
      taken_at = value.gsub(
        /^(\d{4}):(\d{2}):(\d{2}) (.+)$/, "\\1-\\2-\\3 \\4"
      )
      Time.zone.parse(taken_at)
    when :focal_length
      value.delete(" ")
    when :longitude
      value.to_s
    else
      value
    end
  end
end
