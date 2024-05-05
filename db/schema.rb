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

ActiveRecord::Schema.define(version: 2024_05_05_081927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "baskets", force: :cascade do |t|
    t.string "product_name", null: false
    t.integer "product_qty"
    t.string "product_image"
    t.date "due_date"
    t.bigint "stock_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_baskets_on_stock_id"
    t.index ["user_id"], name: "index_baskets_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "item_name"
    t.string "item_image"
    t.string "item_genre"
    t.string "item_url_pc"
    t.string "item_url_mobile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stock_tags", force: :cascade do |t|
    t.bigint "stock_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["stock_id", "tag_id"], name: "index_stock_tags_on_stock_id_and_tag_id", unique: true
    t.index ["stock_id"], name: "index_stock_tags_on_stock_id"
    t.index ["tag_id"], name: "index_stock_tags_on_tag_id"
    t.index ["user_id"], name: "index_stock_tags_on_user_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "stock_name", null: false
    t.integer "stock_qty", null: false
    t.string "category"
    t.string "note"
    t.string "stock_image"
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time"
    t.index ["item_id"], name: "index_stocks_on_item_id"
    t.index ["user_id"], name: "index_stocks_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "baskets", "stocks"
  add_foreign_key "baskets", "users"
  add_foreign_key "stock_tags", "stocks"
  add_foreign_key "stock_tags", "tags"
  add_foreign_key "stock_tags", "users"
  add_foreign_key "stocks", "items"
  add_foreign_key "stocks", "users"
end
