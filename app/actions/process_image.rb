# frozen_string_literal: true

require "English"
class ProcessImage
  include Voltage.call

  attr_reader :post_id

  def initialize(post_id)
    @post_id = post_id
  end

  def post
    @post ||= Post.find_by(id: post_id)
  end

  def call
    return unless post

    post.raw_photo.open do |raw|
      export_images(raw.path)
      metadata = extract_metadata(raw.path)
      theme = ImageColor.extract(raw.path)

      post.update(
        meta: {
          colors: theme,
          exif: metadata
        }
      )
    end
  end

  def extract_metadata(raw_path)
    cmd = [
      "exiftool",
      "-json",
      "-coordFormat",
      "%+.6f",
      raw_path
    ].map {|arg| Shellwords.escape(arg) }.join(" ")

    payload = `#{cmd}`

    if $CHILD_STATUS.exitstatus.nonzero?
      raise "Unable to extract EXIF: #{payload.chomp}"
    end

    Exif.call(JSON.parse(payload).first)
  end

  def export_images(raw_path)
    basename = File.basename(raw_path, ".*")
    basename = "#{basename}.jpg"

    thumbnail_path = resize(raw_path, size: "700x700", quality: 70)
    large_path = resize(raw_path, size: "2000x2000", quality: 85)

    post.thumbnail.attach(filename: basename, io: File.open(thumbnail_path))
    post.large_photo.attach(filename: basename, io: File.open(large_path))
  end

  def resize(image_path, quality:, size:)
    tmp_file = Tempfile.new.path

    cmd = [
      "magick",
      "convert",
      image_path,
      "-strip",
      "-quality",
      quality,
      "-scale",
      size,
      "JPEG:#{tmp_file}"
    ].map {|arg| Shellwords.escape(arg.to_s) }.join(" ")

    result = `#{cmd}`

    if $CHILD_STATUS.exitstatus.nonzero?
      raise "Unable to export image: #{result.chomp}"
    end

    tmp_file
  end
end
