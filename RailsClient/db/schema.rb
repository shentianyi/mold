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

ActiveRecord::Schema.define(version: 20150818034707) do

  create_table "images", force: :cascade do |t|
    t.string   "filename",      limit: 255, default: "", null: false
    t.string   "disk_filename", limit: 255, default: "", null: false
    t.integer  "filesize",      limit: 4,   default: 0,  null: false
    t.string   "content_type",  limit: 60,  default: ""
    t.string   "description",   limit: 255
    t.integer  "author_id",     limit: 4,   default: 0,  null: false
    t.datetime "created_on"
  end

  create_table "knife_switch_records", force: :cascade do |t|
    t.string   "mould_id",       limit: 255,                 null: false
    t.string   "project_id",     limit: 255, default: ""
    t.datetime "switch_date"
    t.string   "knife_type",     limit: 255, default: ""
    t.string   "knife_kind",     limit: 255, default: ""
    t.string   "knife_supplier", limit: 255, default: ""
    t.string   "state",          limit: 255, default: ""
    t.string   "problem",        limit: 255, default: ""
    t.string   "damage_define",  limit: 255, default: ""
    t.string   "maintainman",    limit: 255, default: ""
    t.integer  "m_qty",          limit: 4
    t.string   "machine_id",     limit: 255, default: ""
    t.integer  "press_num",      limit: 4
    t.integer  "damage_life",    limit: 4
    t.integer  "broken_life",    limit: 4
    t.integer  "total_life",     limit: 4
    t.string   "operater",       limit: 255, default: ""
    t.boolean  "is_ok",          limit: 1,   default: false
    t.string   "sort",           limit: 255, default: ""
    t.string   "outbound_id",    limit: 255, default: ""
    t.string   "image_id",       limit: 255, default: ""
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "knife_switch_records", ["image_id"], name: "index_knife_switch_records_on_image_id", using: :btree
  add_index "knife_switch_records", ["mould_id"], name: "index_knife_switch_records_on_mould_id", using: :btree

  create_table "knife_switch_slices", force: :cascade do |t|
    t.string   "mould_id",          limit: 255,                 null: false
    t.string   "project_id",        limit: 255, default: ""
    t.string   "terminal_leoni_id", limit: 255, default: ""
    t.datetime "switch_date"
    t.string   "knife_type1",       limit: 255, default: ""
    t.string   "knife_type2",       limit: 255, default: ""
    t.string   "wire_type",         limit: 255, default: ""
    t.float    "wire_cross",        limit: 24
    t.string   "image_after",       limit: 255, default: ""
    t.string   "image_before",      limit: 255, default: ""
    t.boolean  "is_ok",             limit: 1,   default: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "knife_switch_slices", ["mould_id"], name: "index_knife_switch_slices_on_mould_id", using: :btree

  create_table "mould_details", force: :cascade do |t|
    t.string   "mould_id",          limit: 255,                 null: false
    t.string   "mould_type",        limit: 255, default: ""
    t.string   "mould_state",       limit: 255, default: ""
    t.string   "mould_supplier",    limit: 255, default: ""
    t.string   "position",          limit: 255, default: ""
    t.string   "terminal_leoni_no", limit: 255, default: ""
    t.string   "terminal_supplier", limit: 255, default: ""
    t.string   "stopwater",         limit: 255, default: ""
    t.string   "use_range",         limit: 255, default: ""
    t.string   "wire_type",         limit: 255, default: ""
    t.float    "wire_cross",        limit: 24
    t.string   "original_param_ch", limit: 255, default: "NO"
    t.string   "original_param_cw", limit: 255, default: "NO"
    t.string   "actual_param_ch",   limit: 255, default: "NO"
    t.string   "actual_param_cw",   limit: 255, default: "NO"
    t.string   "actual_param_ich",  limit: 255, default: "NO"
    t.string   "actual_param_icw",  limit: 255, default: "NO"
    t.string   "step_dch_id",       limit: 255, default: "/"
    t.string   "step_ich_id",       limit: 255, default: "/"
    t.datetime "next_time"
    t.string   "c_up_knife",        limit: 255, default: ""
    t.string   "i_up_knife",        limit: 255, default: ""
    t.string   "c_down_knife",      limit: 255, default: ""
    t.string   "i_down_knife",      limit: 255, default: ""
    t.string   "upper_punch",       limit: 255, default: ""
    t.string   "coc",               limit: 255, default: ""
    t.string   "coh",               limit: 255, default: ""
    t.string   "feeding_claw",      limit: 255, default: ""
    t.string   "after_groove",      limit: 255, default: ""
    t.string   "before_groove",     limit: 255, default: ""
    t.string   "oil_cup",           limit: 255, default: ""
    t.datetime "buy_time"
    t.string   "release_report",    limit: 255
    t.string   "fixed_asset_id",    limit: 255
    t.boolean  "is_idle",           limit: 1,   default: false
    t.boolean  "is_delete",         limit: 1,   default: false
    t.boolean  "is_dirty",          limit: 1,   default: true
    t.boolean  "is_new",            limit: 1,   default: true
    t.datetime "idle_time"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "mould_details", ["mould_id"], name: "index_mould_details_on_mould_id", using: :btree
  add_index "mould_details", ["position"], name: "index_mould_details_on_position", using: :btree

  create_table "mould_maintain_records", force: :cascade do |t|
    t.string   "mould_id",   limit: 255,             null: false
    t.integer  "count",      limit: 4,   default: 0
    t.datetime "plan_date"
    t.datetime "real_date"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "mould_maintain_records", ["count"], name: "index_mould_maintain_records_on_count", using: :btree
  add_index "mould_maintain_records", ["mould_id"], name: "index_mould_maintain_records_on_mould_id", using: :btree

  create_table "mould_maintain_times", force: :cascade do |t|
    t.string   "mould_id",        limit: 255,              null: false
    t.string   "project_id",      limit: 255, default: ""
    t.string   "device_id",       limit: 255, default: ""
    t.string   "serviceman",      limit: 255, default: ""
    t.datetime "maintain_date"
    t.string   "err_note",        limit: 255, default: ""
    t.string   "solution_method", limit: 255, default: ""
    t.string   "code",            limit: 255, default: ""
    t.string   "feed_code",       limit: 255, default: ""
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "downtime"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "mould_maintain_times", ["mould_id"], name: "index_mould_maintain_times_on_mould_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "nr",                     limit: 255,                 null: false
    t.string   "user_name",              limit: 255
    t.integer  "role_id",                limit: 4,                   null: false
    t.string   "tel",                    limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.boolean  "is_delete",              limit: 1,   default: false
    t.boolean  "is_dirty",               limit: 1,   default: true
    t.boolean  "is_new",                 limit: 1,   default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["id"], name: "index_users_on_id", unique: true, using: :btree
  add_index "users", ["nr"], name: "index_users_on_nr", unique: true, using: :btree
  add_index "users", ["user_name"], name: "index_users_on_user_name", using: :btree

end
