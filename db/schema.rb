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

ActiveRecord::Schema.define(version: 20140425021041) do

  create_table "agencies", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "higher_agency_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "agency_id"
    t.integer  "parent_department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "departments", ["agency_id"], name: "index_departments_on_agency_id"

  create_table "menus", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "status"
    t.integer  "display_order"
    t.integer  "parent_menu_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus_roles", id: false, force: true do |t|
    t.integer  "menu_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menus_roles", ["menu_id", "role_id"], name: "index_menus_roles_on_menu_id_and_role_id", unique: true
  add_index "menus_roles", ["menu_id"], name: "index_menus_roles_on_menu_id"
  add_index "menus_roles", ["role_id"], name: "index_menus_roles_on_role_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.integer  "agency_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id"
  end

  add_index "users", ["agency_id"], name: "index_users_on_agency_id"
  add_index "users", ["department_id"], name: "index_users_on_department_id"

  create_table "users_roles", id: false, force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_roles", ["role_id"], name: "index_users_roles_on_role_id"
  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", unique: true
  add_index "users_roles", ["user_id"], name: "index_users_roles_on_user_id"

end
