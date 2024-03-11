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

ActiveRecord::Schema[7.1].define(version: 2024_02_29_012144) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "golf_course_hole_tees", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.integer "yards"
    t.bigint "golf_course_hole_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["golf_course_hole_id"], name: "index_golf_course_hole_tees_on_golf_course_hole_id"
  end

  create_table "golf_course_holes", force: :cascade do |t|
    t.bigint "golf_course_id"
    t.integer "hole"
    t.integer "par"
    t.integer "handicap"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["golf_course_id", "hole"], name: "index_golf_course_holes_on_golf_course_id_and_hole", unique: true
  end

  create_table "golf_course_tee_boxes", force: :cascade do |t|
    t.string "tee"
    t.integer "slope"
    t.decimal "handicap"
    t.bigint "golf_course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["golf_course_id"], name: "index_golf_course_tee_boxes_on_golf_course_id"
  end

  create_table "golf_courses", force: :cascade do |t|
    t.string "name"
    t.integer "remote_api_version"
    t.string "remote_api_id"
    t.string "address"
    t.string "city"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "country"
    t.string "fairway_grass"
    t.string "green_grass"
    t.integer "number_of_holes"
    t.string "length_format"
    t.string "phone"
    t.string "state"
    t.string "website"
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "league_announcements", force: :cascade do |t|
    t.bigint "league_id"
    t.string "title"
    t.text "body"
    t.datetime "published_at"
    t.datetime "unpublished_at"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_league_announcements_on_league_id"
  end

  create_table "league_event_flight_memberships", force: :cascade do |t|
    t.bigint "flight_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_id"], name: "index_league_event_flight_memberships_on_flight_id"
    t.index ["user_id"], name: "index_league_event_flight_memberships_on_user_id"
  end

  create_table "league_event_flights", force: :cascade do |t|
    t.string "name"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_league_event_flights_on_event_id"
  end

  create_table "league_event_round_scorecard_entries", force: :cascade do |t|
    t.integer "score"
    t.datetime "submitted_at"
    t.bigint "scorecard_id"
    t.bigint "hole_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hole_id"], name: "index_league_event_round_scorecard_entries_on_hole_id"
    t.index ["scorecard_id"], name: "index_league_event_round_scorecard_entries_on_scorecard_id"
  end

  create_table "league_event_round_scorecards", force: :cascade do |t|
    t.bigint "round_id"
    t.bigint "user_id"
    t.decimal "score_gross"
    t.decimal "score_net"
    t.decimal "score_best_of_holes"
    t.decimal "score_chicago"
    t.decimal "score_stableford"
    t.integer "computed_score_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["round_id"], name: "index_league_event_round_scorecards_on_round_id"
    t.index ["user_id"], name: "index_league_event_round_scorecards_on_user_id"
  end

  create_table "league_event_rounds", force: :cascade do |t|
    t.integer "position"
    t.integer "scoring_format"
    t.integer "playing_format"
    t.date "start_date"
    t.date "end_date"
    t.integer "starting_hole"
    t.integer "number_of_holes"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_league_event_rounds_on_event_id"
  end

  create_table "league_event_team_team_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_league_event_team_team_users_on_team_id"
    t.index ["user_id"], name: "index_league_event_team_team_users_on_user_id"
  end

  create_table "league_event_teams", force: :cascade do |t|
    t.bigint "event_id"
    t.string "name"
    t.integer "handicap_format", default: 0
    t.integer "handicap"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_league_event_teams_on_event_id"
  end

  create_table "league_events", force: :cascade do |t|
    t.integer "event_type"
    t.date "start_date"
    t.date "end_date"
    t.decimal "entry_fee"
    t.integer "number_of_rounds"
    t.decimal "per_round_fee"
    t.integer "average_holes_per_round"
    t.integer "status", default: 0
    t.bigint "league_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_league_events_on_league_id"
  end

  create_table "league_memberships", force: :cascade do |t|
    t.integer "membership_type"
    t.bigint "league_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_league_memberships_on_league_id"
    t.index ["user_id"], name: "index_league_memberships_on_user_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.string "payment_link"
    t.integer "league_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.integer "role", default: 0
    t.string "ghin_number"
    t.decimal "ghin_handicap"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["ghin_number"], name: "index_users_on_ghin_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
