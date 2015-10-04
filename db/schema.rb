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

ActiveRecord::Schema.define(version: 20150918153823) do

  create_table "categories", force: :cascade do |t|
    t.string   "category"
    t.string   "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["user_id", "category"], name: "index_category", unique: true
  add_index "categories", ["user_id"], name: "index_category_on_user_id"

  create_table "journals", force: :cascade do |t|
    t.date     "document_date",                null: false
    t.integer  "month",                        null: false
    t.string   "remarks",                      null: false
    t.string   "category",                     null: false
    t.integer  "amount",                       null: false
    t.boolean  "summary",       default: true
    t.string   "user_id",                      null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "year"
  end

  add_index "journals", ["user_id", "category"], name: "index_journal_on_category"
  add_index "journals", ["user_id", "document_date"], name: "index_journal_on_document_date"
  add_index "journals", ["user_id", "month"], name: "index_journal_on_month"
  add_index "journals", ["user_id", "year", "month"], name: "index_journal_on_year"
  add_index "journals", ["user_id"], name: "index_journal_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name",                                null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
