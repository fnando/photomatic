# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :photo
  has_one_attached :thumb
  has_one_attached :large

  validates :photo,
            presence: true,
            blob: {
              content_type: Photomatic::Config.photo_mime_types,
              size_range: 1..(10.megabytes)
            }

  defaults description: "",
           country: "",
           region: "",
           city: "",
           camera: "",
           orientation: "landscape",
           visibility: "private"
end
