# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_11_191606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "auth_codes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.binary "encrypted_code", null: false
    t.text "code_digest", null: false
    t.bigint "keyring_id", null: false
    t.timestamptz "expires_at", null: false
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.index ["code_digest"], name: "index_auth_codes_on_code_digest", unique: true
    t.index ["created_at"], name: "index_auth_codes_on_created_at"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.citext "username", null: false
    t.binary "encrypted_email", null: false
    t.text "email_digest", null: false
    t.bigint "keyring_id", null: false
    t.timestamptz "created_at", null: false
    t.timestamptz "updated_at", null: false
    t.index ["created_at"], name: "index_users_on_created_at"
    t.index ["email_digest"], name: "index_users_on_email_digest", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
