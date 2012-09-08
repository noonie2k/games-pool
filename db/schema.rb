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

ActiveRecord::Schema.define(:version => 20120908044421) do

  create_table "games", :force => true do |t|
    t.string   "title"
    t.integer  "platform_id"
    t.string   "img_thumb_url"
    t.string   "img_tiny_url"
    t.integer  "owner_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "games", ["owner_id"], :name => "index_games_on_owner_id"
  add_index "games", ["platform_id"], :name => "index_games_on_platform_id"

  create_table "memberships", :force => true do |t|
    t.integer  "pool_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "memberships", ["pool_id"], :name => "index_memberships_on_pool_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "platforms", :force => true do |t|
    t.string   "name"
    t.string   "color_code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pools", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "invite_code"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "admin"
  end

end
