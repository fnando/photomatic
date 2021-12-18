# frozen_string_literal: true

class CreateAuthCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :auth_codes do |t|
      t.binary :encrypted_code, null: false
      t.text :code_digest, null: false
      t.bigint :keyring_id, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end

    add_index :auth_codes, :code_digest, unique: true
    add_index :auth_codes, :created_at
  end
end
