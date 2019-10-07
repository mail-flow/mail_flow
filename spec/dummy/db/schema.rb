# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_05_070358) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mail_flow_customer_fields", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_mail_flow_customer_fields_on_name", unique: true
  end

  create_table "mail_flow_customers", force: :cascade do |t|
    t.integer "original_id"
    t.string "email"
    t.string "name"
    t.string "first_name"
    t.string "family_name"
    t.string "phone_number"
    t.string "address"
    t.string "zip"
    t.string "city"
    t.jsonb "customer_fields"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_fields"], name: "index_mail_flow_customers_on_customer_fields"
    t.index ["customer_fields"], name: "mail_flow_customers_customer_fields", using: :gin
    t.index ["email"], name: "index_mail_flow_customers_on_email"
    t.index ["name"], name: "index_mail_flow_customers_on_name"
    t.index ["original_id"], name: "index_mail_flow_customers_on_original_id", unique: true
    t.index ["phone_number"], name: "index_mail_flow_customers_on_phone_number"
  end

  create_table "mail_flow_segmentation", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mail_flow_segmentation_conditions", force: :cascade do |t|
    t.bigint "mail_flow_segmentation_group_id", null: false
    t.string "customer_attribute"
    t.string "kind", null: false
    t.string "rule", null: false
    t.string "value", null: false
    t.string "second_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mail_flow_segmentation_group_id"], name: "index_mail_flow_segmentation_conditions_segmentation_group_id"
  end

  create_table "mail_flow_segmentation_groups", force: :cascade do |t|
    t.bigint "mail_flow_segmentation_id", null: false
    t.string "kind", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mail_flow_segmentation_id"], name: "index_mail_flow_segmentation_groups_mail_flow_segmentation_id"
  end

  add_foreign_key "mail_flow_segmentation_conditions", "mail_flow_segmentation_groups"
  add_foreign_key "mail_flow_segmentation_groups", "mail_flow_segmentation"
end
