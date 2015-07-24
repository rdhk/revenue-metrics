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

ActiveRecord::Schema.define(version: 20150722122840) do

  create_table "bvmrs", force: :cascade do |t|
    t.float    "bvmr_value"
    t.datetime "api_time"
  end

  create_table "ivmrs", force: :cascade do |t|
    t.float    "ivmr_value"
    t.datetime "api_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pvmrs", force: :cascade do |t|
    t.integer  "total_value"
    t.datetime "date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "num_packages"
  end

  create_table "samples", force: :cascade do |t|
    t.datetime "order_date"
    t.float    "sales"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
