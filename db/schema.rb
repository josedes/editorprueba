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

ActiveRecord::Schema.define(version: 20150324160622) do

  create_table "contenidos", force: :cascade do |t|
    t.string   "titulo"
    t.text     "contenido"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menu_nivel0s", force: :cascade do |t|
    t.string   "titulo"
    t.string   "estado"
    t.integer  "posicion"
    t.integer  "contenido_id"
    t.integer  "usuario_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "enlace"
  end

  add_index "menu_nivel0s", ["contenido_id"], name: "index_menu_nivel0s_on_contenido_id"
  add_index "menu_nivel0s", ["usuario_id"], name: "index_menu_nivel0s_on_usuario_id"

  create_table "menu_nivel1s", force: :cascade do |t|
    t.string   "titulo"
    t.integer  "tipo"
    t.integer  "estado"
    t.integer  "posicion"
    t.integer  "MenuNivel0_id"
    t.integer  "contenido_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "enlace"
  end

  add_index "menu_nivel1s", ["MenuNivel0_id"], name: "index_menu_nivel1s_on_MenuNivel0_id"
  add_index "menu_nivel1s", ["contenido_id"], name: "index_menu_nivel1s_on_contenido_id"

  create_table "menu_nivel2s", force: :cascade do |t|
    t.string   "titulo"
    t.integer  "tipo"
    t.integer  "estado"
    t.integer  "posicion"
    t.string   "MenuNivel1references"
    t.integer  "contenido_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "enlace"
  end

  add_index "menu_nivel2s", ["contenido_id"], name: "index_menu_nivel2s_on_contenido_id"

  create_table "usuarios", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "nombre"
    t.string   "apellido"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true

end