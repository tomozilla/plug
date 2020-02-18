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

ActiveRecord::Schema.define(version: 2020_02_18_113645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.string "genres"
    t.string "image"
    t.string "spotify_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists_tracks", force: :cascade do |t|
    t.bigint "track_id"
    t.bigint "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_artists_tracks_on_artist_id"
    t.index ["track_id"], name: "index_artists_tracks_on_track_id"
  end

  create_table "events", force: :cascade do |t|
    t.date "date"
    t.string "venue"
    t.float "longitude"
    t.float "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.string "name"
    t.string "album"
    t.string "spotify_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracks_users", force: :cascade do |t|
    t.bigint "track_id"
    t.bigint "user_id"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "event_id"
    t.index ["event_id"], name: "index_tracks_users_on_event_id"
    t.index ["track_id"], name: "index_tracks_users_on_track_id"
    t.index ["user_id"], name: "index_tracks_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "longitude"
    t.float "latitude"
    t.string "genres"
    t.string "spotify_id"
    t.string "access_token"
    t.string "refresh_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_events", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_users_events_on_event_id"
    t.index ["user_id"], name: "index_users_events_on_user_id"
  end

  add_foreign_key "artists_tracks", "artists"
  add_foreign_key "artists_tracks", "tracks"
  add_foreign_key "tracks_users", "events"
  add_foreign_key "tracks_users", "tracks"
  add_foreign_key "tracks_users", "users"
  add_foreign_key "users_events", "events"
  add_foreign_key "users_events", "users"
end
