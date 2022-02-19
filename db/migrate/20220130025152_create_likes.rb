# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.belongs_to :user, null: true, foreign_key: true
      t.belongs_to :post, null: false, foreign_key: true
      t.datetime :created_at, null: false
    end

    add_index :likes, %i[user_id post_id], unique: true
  end
end
