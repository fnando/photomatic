# frozen_string_literal: true

class PostForm < Form
  attribute :description, :string
  attribute :keywords, :string
  attribute :show_location, :boolean
  attribute :visibility, :string

  def keywords=(keywords)
    keywords = if keywords.is_a?(Array)
                 keywords.join(", ")
               else
                 keywords.split(/\s*,\s*/).uniq.sort.join(", ")
               end
    super(keywords)
  end
end
