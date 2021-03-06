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

ActiveRecord::Schema.define(version: 20170621222500) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string   "uid"
    t.string   "token"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_authentications_on_user_id", using: :btree
  end

  create_table "busies", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_busies_on_user_id", using: :btree
  end

  create_table "event_photos", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_tags", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_tags_on_event_id", using: :btree
    t.index ["tag_id"], name: "index_event_tags_on_tag_id", using: :btree
  end

  create_table "event_users", force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.index ["event_id"], name: "index_event_users_on_event_id", using: :btree
    t.index ["user_id"], name: "index_event_users_on_user_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "location"
    t.integer  "age_limit"
    t.integer  "price"
    t.integer  "host_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "status"
    t.string   "tags",        default: [],              array: true
    t.string   "images",      default: [],              array: true
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "state"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "object"
    t.integer  "objectid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_favorites_on_user_id", using: :btree
  end

  create_table "friends", force: :cascade do |t|
    t.integer  "firstid"
    t.integer  "secondid"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "style_photos", force: :cascade do |t|
    t.integer  "style_id"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "price"
    t.string   "link"
  end

  create_table "style_tags", force: :cascade do |t|
    t.integer  "style_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["style_id"], name: "index_style_tags_on_style_id", using: :btree
    t.index ["tag_id"], name: "index_style_tags_on_tag_id", using: :btree
  end

  create_table "styles", force: :cascade do |t|
    t.string   "name"
    t.string   "tags",       default: [],              array: true
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "images",     default: [],              array: true
    t.string   "price"
    t.index ["user_id"], name: "index_styles_on_user_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.string   "gender"
    t.json     "avatar"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  add_foreign_key "authentications", "users"
  add_foreign_key "busies", "users"
  add_foreign_key "event_tags", "events"
  add_foreign_key "event_tags", "tags"
  add_foreign_key "event_users", "events"
  add_foreign_key "event_users", "users"
  add_foreign_key "favorites", "users"
  add_foreign_key "style_tags", "styles"
  add_foreign_key "style_tags", "tags"
  add_foreign_key "styles", "users"
end
