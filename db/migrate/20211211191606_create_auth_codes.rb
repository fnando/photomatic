# frozen_string_literal: true

class CreateAuthCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :auth_codes do |t|
      t.text :code, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end

    add_index :auth_codes, :code, unique: true
  end
end
