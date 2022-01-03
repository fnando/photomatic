# frozen_string_literal: true

class PostForm < Form
  attribute :description, :string
  attribute :keywords, :string
  attribute :show_location, :boolean
  attribute :visibility, :string

  validates :description, presence: {include_blank: false}
end
