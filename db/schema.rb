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

ActiveRecord::Schema[7.0].define(version: 2022_12_15_232955) do
  create_table "players", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "season_ownerships", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "season_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_season_ownerships_on_season_id"
  end

  create_table "seasons", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "Season_name"
    t.string "Shortened_season_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stage_rounds", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "round_name"
    t.bigint "tournament_stage_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["round_name", "tournament_stage_id"], name: "index_stage_rounds_on_round_name_and_tournament_stage_id", unique: true
    t.index ["tournament_stage_id"], name: "index_stage_rounds_on_tournament_stage_id"
  end

  create_table "teams", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "Team_name"
    t.string "Shortened_team_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tournament_stages", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "stage_name", null: false
    t.bigint "tournament_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stage_name", "tournament_id"], name: "index_tournament_stages_on_stage_name_and_tournament_id", unique: true
    t.index ["tournament_id"], name: "index_tournament_stages_on_tournament_id"
  end

  create_table "tournament_teams", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_tournament_teams_on_team_id"
  end

  create_table "tournaments", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "tournament_name", null: false
    t.bigint "season_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_tournaments_on_season_id"
    t.index ["tournament_name", "season_id"], name: "index_tournaments_on_tournament_name_and_season_id", unique: true
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "username", null: false
    t.string "password", null: false
    t.boolean "is_admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "players", "teams"
  add_foreign_key "season_ownerships", "seasons"
  add_foreign_key "stage_rounds", "tournament_stages"
  add_foreign_key "tournament_stages", "tournaments"
  add_foreign_key "tournament_teams", "teams"
  add_foreign_key "tournaments", "seasons"
end
