# frozen_string_literal: true

class UsernameExtractor
  REGEX = /(?:@\b([a-z0-9_]+))\b/im
  UNDERSCORE = "_"

  def self.call(text)
    text
      .scan(REGEX)
      .flatten
      .select {|match| valid?(match) }
      .uniq(&:downcase)
  end

  def self.valid?(match)
    !match.start_with?(UNDERSCORE) &&
      !match.end_with?(UNDERSCORE) &&
      match.exclude?("__")
  end
end
