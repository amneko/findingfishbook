# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_31_184414) do
  create_table "aquariums", force: :cascade do |t|
    t.string "name", null: false
    t.integer "prefecture_id", null: false
    t.string "address", null: false
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prefecture_id"], name: "index_aquariums_on_prefecture_id"
  end

  create_table "fishes", force: :cascade do |t|
    t.string "name", null: false
    t.integer "location_id", null: false
    t.integer "selling_price_tanuki", null: false
    t.integer "selling_price_justin", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_fishes_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "north_appearances", force: :cascade do |t|
    t.integer "fish_id", null: false
    t.string "north_month", null: false
    t.string "latenight_starttime"
    t.string "latenight_endtime"
    t.string "morning_starttime"
    t.string "morning_endtime"
    t.string "noon_starttime"
    t.string "noon_endtime"
    t.string "evening_starttime"
    t.string "evening_endtime"
    t.string "night_starttime"
    t.string "night_endtime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fish_id"], name: "index_north_appearances_on_fish_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "fish_id", null: false
    t.integer "aquarium_id", null: false
    t.string "post_image"
    t.date "shooting_date"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aquarium_id"], name: "index_posts_on_aquarium_id"
    t.index ["fish_id"], name: "index_posts_on_fish_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name", null: false
    t.string "icon"
    t.string "like_fish"
    t.string "like_aquarium"
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "aquariums", "prefectures"
  add_foreign_key "fishes", "locations"
  add_foreign_key "north_appearances", "fishes"
  add_foreign_key "posts", "aquariums"
  add_foreign_key "posts", "fishes"
  add_foreign_key "posts", "users"
end
