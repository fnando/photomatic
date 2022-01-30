# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :restrict_with_exception

  has_one_attached :raw_photo
  has_one_attached :thumbnail
  has_one_attached :large_photo

  validates :raw_photo,
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
