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

ActiveRecord::Schema.define(version: 2020_08_17_004009) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comercios", force: :cascade do |t|
    t.string "nombre"
    t.string "domicilio"
    t.string "telefono"
    t.string "celular"
    t.string "web"
    t.string "facebook"
    t.string "instagram"
    t.string "twitter"
    t.string "latitud"
    t.string "longitud"
    t.string "email"
    t.bigint "rubro_id"
    t.bigint "provincia_id"
    t.bigint "departamento_id"
    t.bigint "localidad_id"
    t.string "descripcion"
    t.bigint "usuario_id"
    t.boolean "entrega", default: false
    t.boolean "activo", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["departamento_id"], name: "index_comercios_on_departamento_id"
    t.index ["localidad_id"], name: "index_comercios_on_localidad_id"
    t.index ["provincia_id"], name: "index_comercios_on_provincia_id"
    t.index ["rubro_id"], name: "index_comercios_on_rubro_id"
    t.index ["usuario_id"], name: "index_comercios_on_usuario_id"
  end

  create_table "departamentos", force: :cascade do |t|
    t.string "nombre"
    t.bigint "provincia_id"
    t.boolean "activo", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provincia_id"], name: "index_departamentos_on_provincia_id"
  end

  create_table "horarios", force: :cascade do |t|
    t.integer "dia"
    t.time "desde"
    t.time "hasta"
    t.bigint "comercio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comercio_id"], name: "index_horarios_on_comercio_id"
  end

  create_table "localidades", force: :cascade do |t|
    t.string "nombre"
    t.bigint "departamento_id"
    t.bigint "provincia_id"
    t.boolean "activo", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["departamento_id"], name: "index_localidades_on_departamento_id"
    t.index ["provincia_id"], name: "index_localidades_on_provincia_id"
  end

  create_table "provincias", force: :cascade do |t|
    t.string "nombre"
    t.boolean "activo", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "referencias", force: :cascade do |t|
    t.string "cuerpo"
    t.bigint "usuario_id"
    t.bigint "comercio_id"
    t.integer "puntaje"
    t.boolean "activo", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comercio_id"], name: "index_referencias_on_comercio_id"
    t.index ["usuario_id"], name: "index_referencias_on_usuario_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rubros", force: :cascade do |t|
    t.string "descripcion"
    t.boolean "activo", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.string "nombre"
    t.string "telefono"
    t.string "celular"
    t.string "domicilio"
    t.boolean "habilitado", default: false
    t.boolean "activo", default: true
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "rol_id"
    t.bigint "provincia_id"
    t.bigint "departamento_id"
    t.bigint "localidad_id"
    t.index ["confirmation_token"], name: "index_usuarios_on_confirmation_token", unique: true
    t.index ["departamento_id"], name: "index_usuarios_on_departamento_id"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["localidad_id"], name: "index_usuarios_on_localidad_id"
    t.index ["provincia_id"], name: "index_usuarios_on_provincia_id"
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
    t.index ["rol_id"], name: "index_usuarios_on_rol_id"
    t.index ["uid", "provider"], name: "index_usuarios_on_uid_and_provider", unique: true
  end

  add_foreign_key "comercios", "departamentos"
  add_foreign_key "comercios", "localidades"
  add_foreign_key "comercios", "provincias"
  add_foreign_key "comercios", "rubros"
  add_foreign_key "comercios", "usuarios"
  add_foreign_key "departamentos", "provincias"
  add_foreign_key "horarios", "comercios"
  add_foreign_key "localidades", "departamentos"
  add_foreign_key "localidades", "provincias"
  add_foreign_key "referencias", "comercios"
  add_foreign_key "referencias", "usuarios"
  add_foreign_key "usuarios", "departamentos"
  add_foreign_key "usuarios", "localidades"
  add_foreign_key "usuarios", "provincias"
  add_foreign_key "usuarios", "roles"
end
