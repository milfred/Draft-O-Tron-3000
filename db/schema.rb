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

ActiveRecord::Schema.define(version: 20160917010625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "measurables", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "season_id"
    t.integer  "games_played"
    t.integer  "games_started"
    t.integer  "pass_yards"
    t.integer  "pass_tds"
    t.integer  "interceptions"
    t.integer  "pass_2pt_conv"
    t.integer  "rush_yards"
    t.integer  "rush_tds"
    t.integer  "rush_2pt_conv"
    t.integer  "receptions"
    t.integer  "receive_yards"
    t.integer  "receive_tds"
    t.integer  "receive_2pt_conv"
    t.integer  "fumbles"
    t.integer  "fumbles_lost"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "players", force: :cascade do |t|
    t.integer  "api_player_id"
    t.string   "name"
    t.string   "team"
    t.string   "position"
    t.integer  "experience"
    t.boolean  "active"
    t.string   "photo_url"
    t.integer  "bye_week"
    t.integer  "depth_order"
    t.integer  "draft_round"
    t.integer  "draft_pick"
    t.string   "rotowire_url"
    t.float    "adp"
    t.float    "adp_ppr"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "rankings", force: :cascade do |t|
    t.integer  "sheet_id"
    t.integer  "player_id"
    t.integer  "player_rank"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "status"
  end

  create_table "seasons", force: :cascade do |t|
    t.integer  "season"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sheets", force: :cascade do |t|
    t.string   "url_parameter"
    t.float    "pass_yard_pts"
    t.float    "pass_td_pts"
    t.float    "int_pts"
    t.float    "rush_yard_pts"
    t.float    "rush_td_pts"
    t.float    "rec_pts"
    t.float    "rec_yard_pts"
    t.float    "rec_td_pts"
    t.float    "avg_qb_proj"
    t.float    "avg_rb_proj"
    t.float    "avg_wr_proj"
    t.float    "avg_te_proj"
    t.string   "slug"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "sheets", ["slug"], name: "index_sheets_on_slug", unique: true, using: :btree

end
