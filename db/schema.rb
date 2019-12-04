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

ActiveRecord::Schema.define(version: 2019_11_26_182528) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "market_ratings", force: :cascade do |t|
    t.bigint "market_id"
    t.bigint "user_id"
    t.integer "rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["market_id"], name: "index_market_ratings_on_market_id"
    t.index ["user_id"], name: "index_market_ratings_on_user_id"
  end

  create_table "markets", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "facebook_event_id"
    t.integer "category"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "place"
    t.string "image"
    t.float "average_rating"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.index ["user_id"], name: "index_markets_on_user_id"
  end

  create_table "product_ratings", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "user_id"
    t.integer "rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_ratings_on_product_id"
    t.index ["user_id"], name: "index_product_ratings_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", null: false
    t.integer "price", null: false
    t.string "picture"
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "average_rating"
    t.text "description"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "products_markets", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "market_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["market_id"], name: "index_products_markets_on_market_id"
    t.index ["product_id"], name: "index_products_markets_on_product_id"
  end

  create_table "user_ratings", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.bigint "rater_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rater_id"], name: "index_user_ratings_on_rater_id"
    t.index ["user_id"], name: "index_user_ratings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "email", null: false
    t.string "password"
    t.string "phone_number"
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "products_count"
    t.float "average_rating"
    t.string "avatar"
  end

  add_foreign_key "market_ratings", "markets"
  add_foreign_key "market_ratings", "users"
  add_foreign_key "markets", "users"
  add_foreign_key "product_ratings", "products"
  add_foreign_key "product_ratings", "users"
  add_foreign_key "products", "users"
  add_foreign_key "products_markets", "markets"
  add_foreign_key "products_markets", "products"
  add_foreign_key "user_ratings", "users"
  add_foreign_key "user_ratings", "users", column: "rater_id"
end
