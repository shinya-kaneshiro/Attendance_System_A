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

ActiveRecord::Schema.define(version: 20201001232503) do

  create_table "application_statuses", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attendance_changes", force: :cascade do |t|
    t.string "applicant"
    t.date "worked_on"
    t.integer "attendance_id"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "started_at_change"
    t.datetime "finished_at_change"
    t.boolean "next_day_flag"
    t.string "note"
    t.string "status"
    t.string "superior_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attendance_confirmations", force: :cascade do |t|
    t.string "applicant"
    t.date "application_month"
    t.string "status"
    t.string "superior_id"
    t.boolean "check_box"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string "note"
    t.string "change_reason"
    t.boolean "next_day_flag"
    t.string "superior_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "bases", force: :cascade do |t|
    t.string "base_number"
    t.string "base_name"
    t.string "attendance_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "affiliation"
    t.string "employee_number"
    t.string "uid"
    t.datetime "basic_work_time", default: "2020-10-02 08:00:00"
    t.datetime "designated_work_start_time", default: "2020-10-02 09:00:00"
    t.datetime "designated_work_end_time", default: "2020-10-02 18:00:00"
    t.boolean "superior"
    t.boolean "admin"
    t.string "password_digest"
    t.string "remember_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
