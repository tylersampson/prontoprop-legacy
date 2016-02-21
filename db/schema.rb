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

ActiveRecord::Schema.define(version: 20160221143103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "database"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.string   "unit"
    t.string   "complex"
    t.string   "street_no"
    t.string   "street_name"
    t.string   "crossing_street"
    t.string   "suburb"
    t.string   "city"
    t.string   "country"
    t.string   "code"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "addresses", ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", using: :btree

  create_table "agent_properties", force: :cascade do |t|
    t.integer  "agent_id"
    t.integer  "property_id"
    t.decimal  "commission_percent", precision: 5, scale: 2
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "agent_properties", ["agent_id"], name: "index_agent_properties_on_agent_id", using: :btree
  add_index "agent_properties", ["property_id"], name: "index_agent_properties_on_property_id", using: :btree

  create_table "agents", force: :cascade do |t|
    t.string   "code"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "id_number"
    t.string   "email"
    t.string   "mobile"
    t.decimal  "tax",        precision: 4, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "attorneys", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "email"
    t.string   "telephone"
    t.boolean  "preferred"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "banks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.date     "event_on"
    t.text     "comments"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "commissions", force: :cascade do |t|
    t.integer  "commissionable_id"
    t.string   "commissionable_type"
    t.integer  "agent_id"
    t.decimal  "commission_percent",  precision: 5,  scale: 2
    t.decimal  "gross_amount",        precision: 12, scale: 2
    t.decimal  "tax_percent",         precision: 5,  scale: 2
    t.decimal  "total_tax",           precision: 12, scale: 2
    t.decimal  "nett_amount",         precision: 12, scale: 2
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.date     "paid_on"
  end

  add_index "commissions", ["agent_id"], name: "index_commissions_on_agent_id", using: :btree
  add_index "commissions", ["commissionable_type", "commissionable_id"], name: "index_commissions_on_commissionable_type_and_commissionable_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "contactable_id"
    t.string   "contactable_type"
    t.string   "name"
    t.string   "email"
    t.string   "mobile"
    t.string   "telephone"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "contacts", ["contactable_type", "contactable_id"], name: "index_contacts_on_contactable_type_and_contactable_id", using: :btree

  create_table "deductables", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.decimal  "unit_price", precision: 12, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "deductions", force: :cascade do |t|
    t.integer  "commission_id"
    t.integer  "deductable_id"
    t.decimal  "amount",        precision: 12, scale: 2
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "deductions", ["commission_id"], name: "index_deductions_on_commission_id", using: :btree
  add_index "deductions", ["deductable_id"], name: "index_deductions_on_deductable_id", using: :btree

  create_table "leases", force: :cascade do |t|
    t.string   "code"
    t.integer  "property_id"
    t.integer  "lessor_id"
    t.boolean  "managed"
    t.date     "start_on"
    t.date     "end_on"
    t.date     "actual_end_on"
    t.decimal  "rent_amount",              precision: 12, scale: 2
    t.decimal  "deposit_amount",           precision: 12, scale: 2
    t.string   "deposit_held_by"
    t.decimal  "lease_fee",                precision: 12, scale: 2
    t.decimal  "inspection_fee",           precision: 12, scale: 2
    t.decimal  "credit_check_fee",         precision: 12, scale: 2
    t.date     "credit_check_fee_paid_on"
    t.date     "deposit_released_on"
    t.string   "deposit_released_to"
    t.integer  "status_id"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "leases", ["lessor_id"], name: "index_leases_on_lessor_id", using: :btree
  add_index "leases", ["property_id"], name: "index_leases_on_property_id", using: :btree
  add_index "leases", ["status_id"], name: "index_leases_on_status_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "originators", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "email"
    t.string   "telephone"
    t.boolean  "preferred"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "properties", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "owner_id"
    t.string   "listing_type"
    t.string   "external_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "properties", ["owner_id"], name: "index_properties_on_owner_id", using: :btree

  create_table "rentals", force: :cascade do |t|
    t.integer  "lease_id"
    t.date     "date_received"
    t.decimal  "amount_received", precision: 12, scale: 2
    t.decimal  "commission",      precision: 12, scale: 2
    t.decimal  "vat",             precision: 12, scale: 2
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "import_id"
    t.decimal  "fees",            precision: 12, scale: 2
    t.string   "code"
  end

  add_index "rentals", ["lease_id"], name: "index_rentals_on_lease_id", using: :btree

  create_table "sales", force: :cascade do |t|
    t.string   "code"
    t.integer  "property_id"
    t.integer  "buyer_id"
    t.decimal  "purchase_price",    precision: 12, scale: 2
    t.decimal  "deposit_amount",    precision: 12, scale: 2
    t.date     "deposit_due_on"
    t.integer  "attorney_id"
    t.integer  "bond_attorney_id"
    t.date     "bond_due_on"
    t.integer  "originator_id"
    t.string   "external_id"
    t.decimal  "commission",        precision: 12, scale: 2
    t.decimal  "vat",               precision: 12, scale: 2
    t.integer  "status_id"
    t.date     "registered_on"
    t.date     "contract_start_on"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "bank_id"
    t.decimal  "grant_amount",      precision: 12, scale: 2
  end

  add_index "sales", ["attorney_id"], name: "index_sales_on_attorney_id", using: :btree
  add_index "sales", ["bank_id"], name: "index_sales_on_bank_id", using: :btree
  add_index "sales", ["bond_attorney_id"], name: "index_sales_on_bond_attorney_id", using: :btree
  add_index "sales", ["buyer_id"], name: "index_sales_on_buyer_id", using: :btree
  add_index "sales", ["contract_start_on"], name: "index_sales_on_contract_start_on", using: :btree
  add_index "sales", ["originator_id"], name: "index_sales_on_originator_id", using: :btree
  add_index "sales", ["property_id"], name: "index_sales_on_property_id", using: :btree
  add_index "sales", ["registered_on"], name: "index_sales_on_registered_on", using: :btree
  add_index "sales", ["status_id"], name: "index_sales_on_status_id", using: :btree

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.integer  "access"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "agent_properties", "agents"
  add_foreign_key "agent_properties", "properties"
  add_foreign_key "comments", "users"
  add_foreign_key "commissions", "agents"
  add_foreign_key "deductions", "commissions"
  add_foreign_key "deductions", "deductables"
  add_foreign_key "leases", "contacts", column: "lessor_id"
  add_foreign_key "leases", "properties"
  add_foreign_key "leases", "statuses"
  add_foreign_key "properties", "contacts", column: "owner_id"
  add_foreign_key "rentals", "leases"
  add_foreign_key "sales", "attorneys"
  add_foreign_key "sales", "attorneys", column: "bond_attorney_id"
  add_foreign_key "sales", "banks"
  add_foreign_key "sales", "contacts", column: "buyer_id"
  add_foreign_key "sales", "originators"
  add_foreign_key "sales", "properties"
  add_foreign_key "sales", "statuses"
end
