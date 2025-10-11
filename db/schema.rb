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

ActiveRecord::Schema[8.0].define(version: 2025_10_11_104023) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "job_applications", force: :cascade do |t|
    t.string "company_name", null: false
    t.string "job_title", null: false
    t.string "application_link"
    t.date "application_date", null: false
    t.string "current_status", default: "applied", null: false
    t.datetime "status_updated_at"
    t.string "rejected_at_stage"
    t.integer "salary_range_min"
    t.integer "salary_range_max"
    t.string "contact_name"
    t.string "contact_email"
    t.text "notes"
    t.date "follow_up_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_date"], name: "index_job_applications_on_application_date"
    t.index ["company_name"], name: "index_job_applications_on_company_name"
    t.index ["current_status"], name: "index_job_applications_on_current_status"
    t.index ["follow_up_date"], name: "index_job_applications_on_follow_up_date"
  end
end
