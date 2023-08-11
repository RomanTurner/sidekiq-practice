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

ActiveRecord::Schema[7.0].define(version: 2023_08_05_204926) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acidic_job_runs", force: :cascade do |t|
    t.boolean "staged", default: false, null: false
    t.string "idempotency_key", null: false
    t.text "serialized_job", null: false
    t.string "job_class", null: false
    t.datetime "last_run_at", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "locked_at"
    t.string "recovery_point"
    t.text "error_object"
    t.text "attr_accessors"
    t.text "workflow"
    t.bigint "awaited_by_id"
    t.text "returning_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["awaited_by_id"], name: "index_acidic_job_runs_on_awaited_by_id"
    t.index ["idempotency_key"], name: "index_acidic_job_runs_on_idempotency_key", unique: true
  end

  create_table "assignments", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "due_date"
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_assignments_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.bigint "department_id", null: false
    t.bigint "teacher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_courses_on_department_id"
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "head_id"
    t.index ["head_id"], name: "index_departments_on_head_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "course_id", null: false
    t.string "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "submissions", force: :cascade do |t|
    t.bigint "assignment_id", null: false
    t.bigint "student_id", null: false
    t.date "submitted_at"
    t.string "file_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_submissions_on_assignment_id"
    t.index ["student_id"], name: "index_submissions_on_student_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "department_id"
    t.index ["department_id"], name: "index_teachers_on_department_id"
  end

  add_foreign_key "assignments", "courses"
  add_foreign_key "courses", "departments"
  add_foreign_key "courses", "teachers"
  add_foreign_key "departments", "teachers", column: "head_id"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "students"
  add_foreign_key "submissions", "assignments"
  add_foreign_key "submissions", "students"
  add_foreign_key "teachers", "departments"
end
