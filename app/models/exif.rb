# frozen_string_literal: true

class Exif
  ATTRIBUTES = {
    taken_at: %w[DateTimeOriginal DateTimeCreated DateCreated],
    make: ["Make"],
    lens: %w[LensModel LensInfo Lens LensID],
    lens_make: ["LensMake"],
    model: ["Model"],
    width: ["ImageWidth"],
    height: ["ImageHeight"],
    aperture: ["Aperture"],
    latitude: ["GPSLatitude"],
    longitude: ["GPSLongitude"],
    shutter_speed: ["ShutterSpeed"],
    flash: ["Flash"],
    iso: ["ISO"],
    fstop: ["FNumber"],
    focal_length: ["FocalLengthIn35mmFormat"]
  }.freeze

  def self.extract_from_file(path)
    cmd = [
      "exiftool",
      "-json",
      "-coordFormat",
      "%+.6f",
      path
    ].map {|arg| Shellwords.escape(arg) }.join(" ")

    payload = `#{cmd}`

    if $CHILD_STATUS.exitstatus.nonzero?
      raise "Unable to extract EXIF: #{payload.chomp}"
    end

    Exif.call(JSON.parse(payload).first)
  end

  def self.call(payload)
    ATTRIBUTES.each_with_object({}) do |(to, from_choices), buffer|
      from = from_choices.find {|choice| payload[choice] }
      buffer[to] = process_value(to, payload[from])
    end
  end

  def self.process_value(key, value)
    return if value.nil?

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
