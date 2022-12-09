# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def text=(text)
    self.text_digest = Digest::MD5.hexdigest(text.to_s.squish)
    write_attribute(:text, text)
  end
end
