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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161222170040) do

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "content"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "deliveries", force: :cascade do |t|
    t.integer  "ratable_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "order_id"
    t.float    "rate_point", default: 4.0
  end

  add_index "deliveries", ["ratable_id"], name: "index_deliveries_on_ratable_id"

  create_table "meals", force: :cascade do |t|
    t.string   "meal_name"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.float    "rate_point", default: 4.0
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "qty"
    t.integer "meal_id"
    t.integer "order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "rates", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "ratable_id"
    t.string   "ratable_type"
    t.integer  "point"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "rates", ["ratable_type", "ratable_id"], name: "index_rates_on_ratable_type_and_ratable_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
