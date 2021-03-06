# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180122000031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "subdomain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subdomain"], name: "index_accounts_on_subdomain", unique: true
  end

  create_table "albums", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "user_id"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_albums_on_account_id"
    t.index ["user_id"], name: "index_albums_on_user_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "user_id"
    t.string "content_type", null: false
    t.text "alt"
    t.text "caption"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "attachment_upload"
    t.bigint "album_id"
    t.index ["account_id"], name: "index_attachments_on_account_id"
    t.index ["album_id"], name: "index_attachments_on_album_id"
    t.index ["user_id"], name: "index_attachments_on_user_id"
  end

  create_table "child_tags", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "child_id"
    t.bigint "attachment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_child_tags_on_account_id"
    t.index ["attachment_id"], name: "index_child_tags_on_attachment_id"
    t.index ["child_id"], name: "index_child_tags_on_child_id"
  end

  create_table "children", force: :cascade do |t|
    t.bigint "account_id"
    t.string "first_name", default: "", null: false
    t.date "birthdate", null: false
    t.string "pronoun", default: "they", null: false
    t.json "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_children_on_account_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "user_id"
    t.string "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_memberships_on_account_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "albums", "accounts"
  add_foreign_key "albums", "users"
  add_foreign_key "attachments", "accounts"
  add_foreign_key "attachments", "albums"
  add_foreign_key "attachments", "users"
  add_foreign_key "child_tags", "accounts"
  add_foreign_key "child_tags", "attachments"
  add_foreign_key "child_tags", "children"
  add_foreign_key "children", "accounts"
  add_foreign_key "memberships", "accounts"
  add_foreign_key "memberships", "users"
end
