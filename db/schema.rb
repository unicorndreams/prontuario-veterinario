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

ActiveRecord::Schema[7.1].define(version: 2024_04_08_005105) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animais", force: :cascade do |t|
    t.string "identificador"
    t.string "genero"
    t.string "status", default: "triagem"
    t.bigint "especie_id", null: false
    t.bigint "recinto_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["especie_id"], name: "index_animais_on_especie_id"
    t.index ["recinto_id"], name: "index_animais_on_recinto_id"
  end

  create_table "especies", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "historicos_animais", force: :cascade do |t|
    t.datetime "data"
    t.bigint "animal_id", null: false
    t.jsonb "dados_animal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_historicos_animais_on_animal_id"
  end

  create_table "recintos", force: :cascade do |t|
    t.string "nome"
    t.string "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "animais", "especies", column: "especie_id"
  add_foreign_key "animais", "recintos"
  add_foreign_key "historicos_animais", "animais"
end
