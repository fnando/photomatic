# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    enable_extension "pgcrypto"

    create_table :users do |t|
      t.binary :encrypted_email, null: false
      t.text :email_digest, null: false
      t.bigint :keyring_id, null: false

      t.timestamps
    end

    add_index :users, :email_digest, unique: true
    add_index :users, :created_at
  end
end
