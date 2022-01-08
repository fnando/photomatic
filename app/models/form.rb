# frozen_string_literal: true

class Form
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Conversion

  attr_accessor :id

  def to_param
    id
  end
end
