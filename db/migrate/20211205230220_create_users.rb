# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    enable_extension "pgcrypto"
    enable_extension "citext"

    create_table :users do |t|
      t.text :display_name, null: false
      t.text :bio, null: false, default: ""
      t.citext :username, null: false, size: 35
      t.binary :encrypted_email, null: false
      t.text :email_digest, null: false
      t.bigint :keyring_id, null: false

      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :users, :email_digest, unique: true
    add_index :users, :created_at
  end
end
