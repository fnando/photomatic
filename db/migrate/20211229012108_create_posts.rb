# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_enum :post_visibility, %w[public private unlisted]
    create_enum :post_orientation, %w[landscape portrait]

    create_table :posts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.text :description, null: false, default: ""
      t.text :country, null: false, default: ""
      t.text :region, null: false, default: ""
      t.text :city, null: false, default: ""
      t.text :camera, null: false, default: ""
      t.column :orientation, :post_orientation, null: false
      t.column :visibility, :post_visibility, null: false, default: "private"
      t.jsonb :meta, null: false, default: {}

      t.timestamps
    end
  end
end
