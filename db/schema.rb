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

ActiveRecord::Schema[7.0].define(version: 2022_03_15_145005) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "game_sets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kingdoms", force: :cascade do |t|
    t.uuid "game_id"
    t.uuid "game_set_id", null: false
    t.bigint "sovereign_id"
    t.string "name", null: false
    t.string "emblem", null: false
    t.string "leader", null: false
    t.integer "title", default: 0, null: false
    t.string "emblem_avatar", null: false
    t.string "leader_avatar", null: false
    t.boolean "ruler", default: false, null: false
    t.integer "vassals_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_kingdoms_on_game_id"
    t.index ["game_set_id"], name: "index_kingdoms_on_game_set_id"
    t.index ["sovereign_id"], name: "index_kingdoms_on_sovereign_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_messages_on_receiver_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  add_foreign_key "kingdoms", "game_sets"
  add_foreign_key "kingdoms", "game_sets", column: "game_id"
  add_foreign_key "kingdoms", "kingdoms", column: "sovereign_id"
  add_foreign_key "messages", "kingdoms", column: "receiver_id"
  add_foreign_key "messages", "kingdoms", column: "sender_id"
end
