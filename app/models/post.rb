# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :photo do |attachment|
    attachment.variant :thumb, resize_to_fill: [350, nil]
    attachment.variant :large, resize_to_fill: [1024, nil]
  end

  defaults description: "",
           country: "",
           region: "",
           city: "",
           camera: "",
           orientation: "landscape"
end
