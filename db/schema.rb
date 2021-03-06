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

ActiveRecord::Schema.define(version: 20160708070508) do

  create_table "alternatives", force: :cascade do |t|
    t.string   "name"
    t.integer  "proposer_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "rank"
  end

  add_index "alternatives", ["proposer_id"], name: "index_alternatives_on_proposer_id"
  add_index "alternatives", ["user_id"], name: "index_alternatives_on_user_id"

  create_table "critical_evaluations", force: :cascade do |t|
    t.integer  "alternative_id"
    t.integer  "rater_id"
    t.integer  "score"
    t.text     "critical_points"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "critical_points", force: :cascade do |t|
    t.integer  "alternative_id"
    t.integer  "point_id"
    t.string   "point_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "proposer_id"
    t.integer  "user_id"
  end

  add_index "critical_points", ["point_type", "point_id"], name: "index_critical_points_on_point_type_and_point_id"

  create_table "evaluations", force: :cascade do |t|
    t.integer  "score"
    t.integer  "rater_id"
    t.string   "rater_type"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "evaluations", ["rateable_type", "rateable_id"], name: "index_evaluations_on_rateable_type_and_rateable_id"
  add_index "evaluations", ["rater_type", "rater_id"], name: "index_evaluations_on_rater_type_and_rater_id"

  create_table "examples", force: :cascade do |t|
    t.string   "exampleable_type"
    t.string   "exampleable"
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "recipient_id"
    t.integer  "actor_id"
    t.datetime "read_at"
    t.string   "action"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "evaluable_type"
    t.integer  "evaluable_id"
    t.string   "collectible_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "collectible_id"
  end

  create_table "requirements", force: :cascade do |t|
    t.integer  "alternative_id"
    t.string   "name"
    t.integer  "user_id"
    t.integer  "proposer_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "strengths", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "proposer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "strengths", ["proposer_id"], name: "index_strengths_on_proposer_id"

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count"
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "weaknesses", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "proposer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "weaknesses", ["proposer_id"], name: "index_weaknesses_on_proposer_id"

end
