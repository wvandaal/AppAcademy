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

ActiveRecord::Schema.define(:version => 20130710193603) do

  create_table "cat_rental_requests", :force => true do |t|
    t.integer  "cat_id"
    t.date     "begin_date"
    t.date     "end_date"
    t.string   "status",     :default => "undecided"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "cat_rental_requests", ["begin_date"], :name => "index_cat_rental_requests_on_begin_date"
  add_index "cat_rental_requests", ["cat_id"], :name => "index_cat_rental_requests_on_cat_id"
  add_index "cat_rental_requests", ["end_date"], :name => "index_cat_rental_requests_on_end_date"

  create_table "cats", :force => true do |t|
    t.date     "birth_date"
    t.string   "color"
    t.string   "name"
    t.string   "sex"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "session_token"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "users", ["session_token"], :name => "index_users_on_session_token"

end
