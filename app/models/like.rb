# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :post, counter_cache: true
end
