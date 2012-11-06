# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121106092636) do

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.datetime "time"
    t.integer  "event_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
    t.string   "mention_users"
  end

  add_index "comments", ["event_id"], :name => "index_comments_on_event_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "events", :force => true do |t|
    t.string   "title"
    t.datetime "start_date"
    t.string   "location"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "content"
    t.integer  "user_id"
    t.string   "fee"
    t.string   "category"
    t.datetime "end_date"
    t.string   "image"
  end

  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "followships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "followships", ["followed_id"], :name => "index_followships_on_followed_id"
  add_index "followships", ["follower_id", "followed_id"], :name => "index_followships_on_follower_id_and_followed_id", :unique => true
  add_index "followships", ["follower_id"], :name => "index_followships_on_follower_id"

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "is_read",    :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "comment_id"
    t.integer  "msg_type"
  end

  add_index "messages", ["comment_id"], :name => "index_messages_on_comment_id"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "name"
    t.string   "city"
    t.string   "school"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "encrypted_password",        :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "email",                     :default => "", :null => false
    t.string   "gender"
    t.string   "website"
    t.string   "tagline"
    t.integer  "events_count",              :default => 0
    t.integer  "comments_count",            :default => 0
    t.integer  "followships_count",         :default => 0
    t.integer  "reverse_followships_count", :default => 0
  end

  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
