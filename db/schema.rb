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

ActiveRecord::Schema.define(version: 20140216162246) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "deposit_addresses", force: true do |t|
    t.integer  "sponsor_id"
    t.integer  "project_id"
    t.string   "bitcoin_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "month_donations", limit: 8
    t.integer  "year_donations",  limit: 8
  end

  add_index "deposit_addresses", ["project_id"], name: "index_deposit_addresses_on_project_id"
  add_index "deposit_addresses", ["sponsor_id"], name: "index_deposit_addresses_on_sponsor_id"

  create_table "deposits", force: true do |t|
    t.integer  "deposit_address_id"
    t.integer  "amount",             limit: 8
    t.string   "input_tx"
    t.integer  "confirmations"
    t.string   "output_tx"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deposits", ["deposit_address_id"], name: "index_deposits_on_deposit_address_id"

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "about"
    t.string   "url"
    t.string   "bitcoin_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "donation_page_url"
    t.integer  "month_donations",   limit: 8
    t.datetime "moderated_at"
    t.integer  "year_donations",    limit: 8
  end

  create_table "sponsors", force: true do |t|
    t.string   "email",                            default: "",    null: false
    t.string   "encrypted_password",               default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.string   "name"
    t.string   "url"
    t.string   "location"
    t.boolean  "private_donations",                default: false
    t.integer  "month_donations",        limit: 8
    t.integer  "year_donations",         limit: 8
  end

  add_index "sponsors", ["confirmation_token"], name: "index_sponsors_on_confirmation_token", unique: true
  add_index "sponsors", ["email"], name: "index_sponsors_on_email", unique: true
  add_index "sponsors", ["reset_password_token"], name: "index_sponsors_on_reset_password_token", unique: true

end
