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

ActiveRecord::Schema.define(version: 2019_10_04_122845) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

end
