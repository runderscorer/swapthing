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

ActiveRecord::Schema.define(version: 20191111000050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.datetime "date"
    t.text     "description"
    t.integer  "max_spend"
    t.integer  "participants"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin_id"
  end

  create_table "invites", force: :cascade do |t|
    t.string   "sender_id",    limit: 255
    t.string   "recipient_id", limit: 255
    t.datetime "accepted_at"
    t.string   "event_id",     limit: 255
    t.string   "created_at",   limit: 255
    t.string   "token",        limit: 255
    t.string   "email",        limit: 255
  end

  create_table "items", force: :cascade do |t|
    t.integer  "wishlist_id"
    t.string   "name",               limit: 255
    t.integer  "price"
    t.string   "notes",              limit: 255
    t.text     "url"
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "image_url"
    t.boolean  "purchased"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.integer "wishlist_id"
    t.integer "partnership_id"
  end

  create_table "partnerships", force: :cascade do |t|
    t.integer "giver_id"
    t.integer "getter_id"
    t.integer "event_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: ""
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token",       limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type",        limit: 255
    t.integer  "invitations_count",                  default: 0
    t.string   "fname",                  limit: 255
    t.string   "lname",                  limit: 255
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
    t.index ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "wishlists", force: :cascade do |t|
    t.string  "name",    limit: 255
    t.integer "user_id"
  end

end
