# frozen_string_literal: true

class CommentSanitizer
  SCRUBBER = Loofah::Scrubber.new do |node|
    unless node.text?
      node.remove
      Loofah::Scrubber::STOP
    end
  end

  def self.call(text)
    Loofah.scrub_fragment(text, :prune).scrub!(SCRUBBER).to_s
  end
end
