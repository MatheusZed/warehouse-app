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

ActiveRecord::Schema.define(version: 2022_01_21_131407) do

  create_table "product_bundle_items", force: :cascade do |t|
    t.integer "product_model_id", null: false
    t.integer "product_bundle_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_bundle_id"], name: "index_product_bundle_items_on_product_bundle_id"
    t.index ["product_model_id"], name: "index_product_bundle_items_on_product_model_id"
  end

  create_table "product_bundles", force: :cascade do |t|
    t.string "name"
    t.string "sku"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_category_warehouses", force: :cascade do |t|
    t.integer "product_category_id", null: false
    t.integer "warehouse_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_category_id"], name: "index_product_category_warehouses_on_product_category_id"
    t.index ["warehouse_id"], name: "index_product_category_warehouses_on_warehouse_id"
  end

  create_table "product_items", force: :cascade do |t|
    t.integer "warehouse_id", null: false
    t.integer "product_model_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "sku"
    t.index ["product_model_id"], name: "index_product_items_on_product_model_id"
    t.index ["warehouse_id"], name: "index_product_items_on_warehouse_id"
  end

  create_table "product_models", force: :cascade do |t|
    t.string "name"
    t.integer "weight"
    t.integer "height"
    t.integer "width"
    t.integer "length"
    t.integer "supplier_id", null: false
    t.string "sku"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_category_id", default: 0, null: false
    t.integer "status", default: 0
    t.index ["product_category_id"], name: "index_product_models_on_product_category_id"
    t.index ["supplier_id"], name: "index_product_models_on_supplier_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "fantasy_name"
    t.string "legal_name"
    t.string "cnpj"
    t.string "address"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "warehouses", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.integer "total_area"
    t.integer "useful_area"
  end

  add_foreign_key "product_bundle_items", "product_bundles"
  add_foreign_key "product_bundle_items", "product_models"
  add_foreign_key "product_category_warehouses", "product_categories"
  add_foreign_key "product_category_warehouses", "warehouses"
  add_foreign_key "product_items", "product_models"
  add_foreign_key "product_items", "warehouses"
  add_foreign_key "product_models", "product_categories"
  add_foreign_key "product_models", "suppliers"
end
