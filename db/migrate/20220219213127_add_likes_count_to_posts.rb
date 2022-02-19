# frozen_string_literal: true

class AddLikesCountToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :likes_count, :bigint, null: false, default: 0
  end
end
