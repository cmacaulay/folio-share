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

ActiveRecord::Schema.define(version: 20170403212819) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collaborations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "folder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["folder_id"], name: "index_collaborations_on_folder_id", using: :btree
    t.index ["user_id"], name: "index_collaborations_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "upload_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["upload_id"], name: "index_comments_on_upload_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "folders", force: :cascade do |t|
    t.string   "name"
    t.integer  "status",     default: 0
    t.integer  "user_id"
    t.integer  "parent_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "is_private", default: true
    t.index ["user_id"], name: "index_folders_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
  end

  create_table "uploads", force: :cascade do |t|
    t.integer  "status",       default: 0
    t.integer  "folder_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "name"
    t.string   "content_type"
    t.integer  "size"
    t.string   "attachment"
    t.boolean  "is_private",   default: true
    t.index ["folder_id"], name: "index_uploads_on_folder_id", using: :btree
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
    t.index ["role_id"], name: "index_user_roles_on_role_id", using: :btree
    t.index ["user_id"], name: "index_user_roles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "cellphone"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "status",          default: 0
    t.string   "token"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "reset_token"
  end

  add_foreign_key "collaborations", "folders"
  add_foreign_key "collaborations", "users"
  add_foreign_key "comments", "uploads"
  add_foreign_key "comments", "users"
  add_foreign_key "uploads", "folders"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
