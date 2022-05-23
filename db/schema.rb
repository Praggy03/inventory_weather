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

ActiveRecord::Schema[7.0].define(version: 2022_05_22_035916) do
  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.integer "state_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cities_on_name", unique: true
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_countries_on_name", unique: true
  end

  create_table "inventories", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "status", default: 1
    t.integer "quantity", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_inventories_on_name", unique: true
  end

  create_table "shipment_inventory_mappings", force: :cascade do |t|
    t.integer "inventory_id", null: false
    t.integer "shipment_id", null: false
    t.integer "quantity", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inventory_id"], name: "index_shipment_inventory_mappings_on_inventory_id"
    t.index ["shipment_id"], name: "index_shipment_inventory_mappings_on_shipment_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.integer "source_id", null: false
    t.integer "destination_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_shipments_on_description", unique: true
    t.index ["destination_id"], name: "index_shipments_on_destination_id"
    t.index ["name"], name: "index_shipments_on_name", unique: true
    t.index ["source_id"], name: "index_shipments_on_source_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name", null: false
    t.integer "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_states_on_country_id"
    t.index ["name"], name: "index_states_on_name", unique: true
  end

  add_foreign_key "cities", "states"
  add_foreign_key "shipment_inventory_mappings", "inventories"
  add_foreign_key "shipment_inventory_mappings", "shipments"
  add_foreign_key "shipments", "cities", column: "destination_id"
  add_foreign_key "shipments", "cities", column: "source_id"
  add_foreign_key "states", "countries"
end
