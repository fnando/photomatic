# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :post, null: false, foreign_key: true
      t.text :text, null: false
      t.text :text_digest, null: false
      t.datetime :deleted_at
      t.citext :tagged_user_ids, null: false, default: [], array: true
      t.datetime :created_at, null: false
    end

    add_index :comments, :deleted_at
    add_index :comments, %i[user_id post_id text_digest], unique: true
  end
end
