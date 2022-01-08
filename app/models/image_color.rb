# frozen_string_literal: true

class ImageColor
  Histogram = Struct.new(:frequency, :color)

  class Theme
    attr_reader :accent, :bg, :fg

    def initialize(accent, bg, fg)
      @accent = accent
      @bg = bg
      @fg = fg
    end

    def as_json(*)
      {
        accent: "##{accent.to_rgb.hex}",
        bg: "##{bg.to_rgb.hex}",
        fg: "##{fg.to_rgb.hex}"
      }
    end
  end

  attr_reader :image_path

  def self.extract(image_path)
    new(image_path).extract
  end

  def initialize(image_path)
    @image_path = image_path
  end

  def histogram
    @histogram ||= begin
      cmd = [
        "magick",
        "convert",
        image_path,
        "-scale",
        "250x250",
        "-colors",
        "10",
        "-format",
        "%c",
        "histogram:info:"
      ].map {|arg| Shellwords.escape(arg) }.join(" ")

      result = `#{cmd}`.chomp

      if $CHILD_STATUS.exitstatus.nonzero?
        throw "Error while retrieving histogram"
      end

      result.lines.map do |line|
        parts = line.strip.split
        hex = parts[2][1..-1][0, 6]

        Histogram.new(
          parts.first.to_i,
          Color::RGB.by_hex(hex).to_hsl
        )
      end
    end
  end

  def grayish?(color)
    rgb = color.to_rgb.to_a.map {|item| (item * 255).to_i }

    rgb.max - rgb.min <= 20
  end

  def extract
    colors = histogram.map(&:color)
    non_grayish_colors = colors.reject {|color| grayish?(color) }

    main_color = non_grayish_colors.max_by do |color|
      (color.saturation * 2) + (color.lightness * 2.5)
    end

    main_color ||= colors.max_by(&:saturation)

    distant_color = colors.max_by do |color|
      ColorDiff.between(
        ColorDiff::Color::RGB.new(*main_color.to_a.map {|c| (c * 255).to_i }),
        ColorDiff::Color::RGB.new(*color.to_a.map {|c| (c * 255).to_i })
      )
    end

    {
      light: generate_light_theme(main_color),
      dark: generate_dark_theme(main_color),
      distant: Theme.new(main_color, distant_color, distant_color)
    }
  end

  def colorful?(color)
    color.saturation.positive? && (10..100).cover?(color.lightness)
  end

  def generate_light_theme(accent)
    fg = accent.dup
    bg = accent.dup

    if colorful?(accent)
      bg.lightness = 90
      fg.lightness = 75
    else
      bg.saturation = 0
      bg.lightness = 90
      fg.saturation = 0
      fg.lightness = 70
    end

    Theme.new(accent, bg, fg)
  end

  def generate_dark_theme(accent)
    fg = accent.dup
    bg = accent.dup

    if colorful?(accent)
      bg.lightness = 10
      fg.lightness = 30
    else
      bg.saturation = 0
      bg.lightness = [
        20,
        histogram.min_by(&:frequency).color.lightness
      ].min + 5
      bg.lightness = 25
      fg.saturation = 0
      fg.lightness = bg.lightness + 15
    end

    Theme.new(accent, bg, fg)
  end
end
