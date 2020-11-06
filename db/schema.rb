# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_05_000514) do

  create_table "performance_tests", force: :cascade do |t|
    t.string "notes"
    t.string "result"
    t.datetime "date_taken"
    t.integer "user_id", null: false
    t.integer "student_id", null: false
    t.integer "test_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_id"], name: "index_performance_tests_on_student_id"
    t.index ["test_type_id"], name: "index_performance_tests_on_test_type_id"
    t.index ["user_id"], name: "index_performance_tests_on_user_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "grad_year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "grad_year"], name: "index_students_on_name_and_grad_year", unique: true
  end

  create_table "test_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "performance_tests", "students"
  add_foreign_key "performance_tests", "test_types"
  add_foreign_key "performance_tests", "users"
end
