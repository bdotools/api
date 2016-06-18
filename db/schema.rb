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

ActiveRecord::Schema.define(version: 20160618104350) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "fuzzystrmatch"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "daum_id"
    t.index ["daum_id"], name: "index_categories_on_daum_id", unique: true, using: :btree
    t.index ["name"], name: "index_categories_on_name", using: :btree
  end

  create_table "constellations", force: :cascade do |t|
    t.string   "name"
    t.integer  "slots"
    t.integer  "slot_order", default: [],              array: true
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "knowledges", force: :cascade do |t|
    t.integer  "combo_delay"
    t.integer  "combo_favor"
    t.integer  "combo_interest"
    t.integer  "combo_length"
    t.integer  "favor_max"
    t.integer  "favor_min"
    t.integer  "interest"
    t.string   "name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "category_id"
    t.integer  "daum_id"
    t.index ["category_id"], name: "index_knowledges_on_category_id", using: :btree
    t.index ["daum_id"], name: "index_knowledges_on_daum_id", unique: true, using: :btree
    t.index ["name"], name: "index_knowledges_on_name", using: :btree
  end

  create_table "results", force: :cascade do |t|
    t.integer "goal"
    t.integer "goal_param"
    t.float   "strict_afl_ev"
    t.float   "success_percentage"
    t.integer "target_interest"
    t.integer "target_favor"
    t.integer "target_id"
    t.integer "knowledge_ids",      default: [],    array: true
    t.integer "version"
    t.boolean "outdated",           default: false
    t.boolean "experimental",       default: false
    t.index ["target_id"], name: "index_results_on_target_id", using: :btree
  end

  create_table "solve_in_progress", force: :cascade do |t|
    t.integer "target_id"
    t.integer "target_interest"
    t.integer "target_favor"
    t.index ["target_id", "target_interest", "target_favor"], name: "index_solve_in_progress_unique", unique: true, using: :btree
    t.index ["target_id"], name: "index_solve_in_progress_on_target_id", using: :btree
  end

  create_table "targets", force: :cascade do |t|
    t.string   "name"
    t.integer  "favor_min"
    t.integer  "favor_max"
    t.integer  "interest_min"
    t.integer  "interest_max"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "category_id"
    t.integer  "constellation_id"
    t.string   "workflow_state",   default: "hidden"
    t.integer  "daum_id"
    t.index ["category_id"], name: "index_targets_on_category_id", using: :btree
    t.index ["constellation_id"], name: "index_targets_on_constellation_id", using: :btree
    t.index ["daum_id"], name: "index_targets_on_daum_id", unique: true, using: :btree
    t.index ["name"], name: "index_targets_on_name", using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "value"
    t.inet     "ip"
    t.integer  "result_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["result_id"], name: "index_votes_on_result_id", using: :btree
  end

  add_foreign_key "knowledges", "categories"
  add_foreign_key "results", "targets"
  add_foreign_key "solve_in_progress", "targets"
  add_foreign_key "targets", "categories"
  add_foreign_key "targets", "constellations"
  add_foreign_key "votes", "results", on_delete: :cascade
end
