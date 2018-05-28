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

ActiveRecord::Schema.define(version: 2018_05_28_005212) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "building_permits", force: :cascade do |t|
    t.datetime "date_issued"
    t.string "permit_number"
    t.string "address"
    t.string "sublocation"
    t.string "building_class"
    t.integer "valuation"
    t.integer "fee"
    t.string "owner_name"
    t.string "contractor_name"
    t.bigint "permit_type_id"
    t.float "latitude"
    t.float "longitude"
    t.index ["permit_type_id"], name: "index_building_permits_on_permit_type_id"
  end

  create_table "permit_types", force: :cascade do |t|
    t.string "name"
    t.string "p_type"
    t.string "p_type_2"
    t.string "p_type_3"
  end

  create_table "saved_searches", force: :cascade do |t|
    t.string "current_url"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "weekly_email", default: 0
    t.string "address"
    t.index ["user_id"], name: "index_saved_searches_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider"], name: "index_users_on_provider"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid"
  end

  add_foreign_key "building_permits", "permit_types"
  add_foreign_key "saved_searches", "users"
end
