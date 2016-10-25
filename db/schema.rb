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

ActiveRecord::Schema.define(version: 20161020220543) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chatroom_pictures", force: :cascade do |t|
    t.integer "picture_id",  null: false
    t.integer "chatroom_id", null: false
    t.boolean "winner"
    t.index ["chatroom_id"], name: "index_chatroom_pictures_on_chatroom_id", using: :btree
    t.index ["picture_id"], name: "index_chatroom_pictures_on_picture_id", using: :btree
  end

  create_table "chatroom_players", force: :cascade do |t|
    t.integer  "user_id",                     null: false
    t.integer  "chatroom_id",                 null: false
    t.boolean  "creator",     default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["chatroom_id"], name: "index_chatroom_players_on_chatroom_id", using: :btree
    t.index ["user_id"], name: "index_chatroom_players_on_user_id", using: :btree
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string   "topic"
    t.string   "slug",       null: false
    t.boolean  "private"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memes", force: :cascade do |t|
    t.string   "caption",    null: false
    t.integer  "user_id",    null: false
    t.integer  "picture_id", null: false
    t.integer  "votes"
    t.boolean  "winner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["picture_id"], name: "index_memes_on_picture_id", using: :btree
    t.index ["user_id"], name: "index_memes_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.string   "content",     null: false
    t.integer  "user_id",     null: false
    t.integer  "chatroom_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "category"
    t.string   "url"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image"
    t.string   "username"
    t.string   "bio"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "meme_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meme_id"], name: "index_votes_on_meme_id", using: :btree
    t.index ["user_id"], name: "index_votes_on_user_id", using: :btree
  end

  add_foreign_key "chatroom_pictures", "chatrooms"
  add_foreign_key "chatroom_pictures", "pictures"
  add_foreign_key "chatroom_players", "chatrooms"
  add_foreign_key "chatroom_players", "users"
  add_foreign_key "memes", "pictures"
  add_foreign_key "memes", "users"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "votes", "memes"
  add_foreign_key "votes", "users"
end
