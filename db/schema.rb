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

ActiveRecord::Schema.define(version: 20161122132307) do

  create_table "clients", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "nickName"
    t.string   "membershipGrade"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "phone_number"
    t.integer  "foodtruck_id"
    t.float    "lat"
    t.float    "lng"
  end

  create_table "clients_foodtrucks", id: false, force: :cascade do |t|
    t.integer "client_id",    null: false
    t.integer "foodtruck_id", null: false
  end

  create_table "festivals", force: :cascade do |t|
    t.string   "title"
    t.string   "place"
    t.date     "period"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "truck_num"
    t.integer  "support_type"
    t.text     "condition"
    t.binary   "image"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "client_id"
  end

  create_table "festivals_owners", id: false, force: :cascade do |t|
    t.integer "owner_id",    null: false
    t.integer "festival_id", null: false
  end

  create_table "foodtrucks", force: :cascade do |t|
    t.string   "name"
    t.integer  "category"
    t.string   "tag"
    t.float    "rating"
    t.boolean  "open"
    t.boolean  "payment_card"
    t.string   "region"
    t.string   "truck_image"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "client_id"
    t.integer  "owner_id"
    t.float    "lat"
    t.float    "lng"
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "foodtruck_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "menus", force: :cascade do |t|
    t.string   "name"
    t.string   "price"
    t.string   "food_image"
    t.integer  "foodtruck_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "owners", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "phone_number"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "business_number"
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "title"
    t.text     "content"
    t.float    "rating"
    t.integer  "client_id"
    t.integer  "foodtruck_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
