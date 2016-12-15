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

ActiveRecord::Schema.define(version: 20161215062511) do

  create_table "deliveries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meals", force: :cascade do |t|
    t.string   "meal_name"
    t.integer  "ratable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "meals", ["ratable_id"], name: "index_meals_on_ratable_id"

  create_table "rates", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "ratable_id"
    t.string   "ratable_type"
    t.integer  "point"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "rates", ["ratable_type", "ratable_id"], name: "index_rates_on_ratable_type_and_ratable_id"

end
