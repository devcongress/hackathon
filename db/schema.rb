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

ActiveRecord::Schema[8.0].define(version: 2025_10_08_003839) do
  create_table "account_identities", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "provider"
    t.string "uid"
    t.index ["account_id"], name: "index_account_identities_on_account_id"
    t.index ["provider"], name: "index_account_identities_on_provider"
    t.index ["uid"], name: "index_account_identities_on_uid"
  end

  create_table "admin_active_session_keys", primary_key: ["admin_id", "session_id"], force: :cascade do |t|
    t.integer "admin_id"
    t.string "session_id"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "last_use", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["admin_id"], name: "index_admin_active_session_keys_on_admin_id"
  end

  create_table "admin_authentication_audit_logs", force: :cascade do |t|
    t.integer "admin_id", null: false
    t.datetime "at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.text "message", null: false
    t.json "metadata"
    t.index ["admin_id", "at"], name: "audit_admin_admin_id_at_idx"
    t.index ["admin_id"], name: "index_admin_authentication_audit_logs_on_admin_id"
    t.index ["at"], name: "audit_admin_at_idx"
  end

  create_table "admin_lockouts", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
    t.datetime "email_last_sent"
  end

  create_table "admin_login_failures", force: :cascade do |t|
    t.integer "number", default: 1, null: false
  end

  create_table "admin_otp_keys", force: :cascade do |t|
    t.string "key", null: false
    t.integer "num_failures", default: 0, null: false
    t.datetime "last_use", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "admin_password_reset_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "admin_recovery_codes", primary_key: ["id", "code"], force: :cascade do |t|
    t.bigint "id"
    t.string "code"
  end

  create_table "admin_remember_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
  end

  create_table "admin_verification_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "requested_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "admins", force: :cascade do |t|
    t.integer "status", default: 1, null: false
    t.string "email", null: false
    t.string "password_hash"
    t.index ["email"], name: "index_admins_on_email", unique: true, where: "status IN (1, 2)"
  end

  create_table "hackathon_check_ins", force: :cascade do |t|
    t.integer "hacker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hacker_id"], name: "index_hackathon_check_ins_on_hacker_id"
  end

  create_table "hackathon_health_and_safeties", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone_number", null: false
    t.integer "hacker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hacker_id"], name: "index_hackathon_health_and_safeties_on_hacker_id"
  end

  create_table "hackathon_invitations", force: :cascade do |t|
    t.string "email", null: false
    t.string "token"
    t.integer "status", default: 0, null: false
    t.integer "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "profile_id"
    t.index ["email", "team_id"], name: "index_hackathon_invitations_on_email_and_team_id", unique: true
    t.index ["profile_id"], name: "index_hackathon_invitations_on_profile_id"
    t.index ["team_id"], name: "index_hackathon_invitations_on_team_id"
  end

  create_table "hackathon_team_memberships", force: :cascade do |t|
    t.integer "hacker_id", null: false
    t.integer "team_id", null: false
    t.integer "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "invitation_id"
    t.index ["hacker_id"], name: "index_hackathon_team_memberships_on_hacker_id", unique: true
    t.index ["invitation_id"], name: "index_hackathon_team_memberships_on_invitation_id"
    t.index ["team_id"], name: "index_hackathon_team_memberships_on_team_id"
  end

  create_table "hackathon_teams", force: :cascade do |t|
    t.string "name", null: false
    t.integer "hacker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index "LOWER(name)", name: "index_hackathon_teams_on_LOWER_name", unique: true
    t.index ["hacker_id"], name: "index_hackathon_teams_on_hacker_id", unique: true
  end

  create_table "hacker_login_change_keys", force: :cascade do |t|
    t.string "key", null: false
    t.string "login", null: false
    t.datetime "deadline", null: false
  end

  create_table "hacker_password_reset_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "hacker_remember_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
  end

  create_table "hacker_verification_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "requested_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "hackers", force: :cascade do |t|
    t.integer "status", default: 1, null: false
    t.string "email", null: false
    t.string "password_hash"
    t.index ["email"], name: "index_hackers_on_email", unique: true, where: "status IN (1, 2)"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "hacker_id", null: false
    t.string "name", null: false
    t.string "telephone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "skillsets"
    t.string "region"
    t.index ["hacker_id"], name: "index_profiles_on_hacker_id", unique: true
  end

  add_foreign_key "account_identities", "hackers", column: "account_id"
  add_foreign_key "admin_active_session_keys", "admins"
  add_foreign_key "admin_authentication_audit_logs", "admins"
  add_foreign_key "admin_lockouts", "admins", column: "id"
  add_foreign_key "admin_login_failures", "admins", column: "id"
  add_foreign_key "admin_otp_keys", "admins", column: "id"
  add_foreign_key "admin_password_reset_keys", "admins", column: "id"
  add_foreign_key "admin_recovery_codes", "admins", column: "id"
  add_foreign_key "admin_remember_keys", "admins", column: "id"
  add_foreign_key "admin_verification_keys", "admins", column: "id"
  add_foreign_key "hackathon_check_ins", "hackers"
  add_foreign_key "hackathon_health_and_safeties", "hackers"
  add_foreign_key "hackathon_invitations", "hackathon_teams", column: "team_id"
  add_foreign_key "hackathon_invitations", "profiles"
  add_foreign_key "hackathon_team_memberships", "hackathon_invitations", column: "invitation_id"
  add_foreign_key "hackathon_team_memberships", "hackathon_teams", column: "team_id"
  add_foreign_key "hackathon_team_memberships", "hackers"
  add_foreign_key "hackathon_teams", "hackers"
  add_foreign_key "hacker_login_change_keys", "hackers", column: "id"
  add_foreign_key "hacker_password_reset_keys", "hackers", column: "id"
  add_foreign_key "hacker_remember_keys", "hackers", column: "id"
  add_foreign_key "hacker_verification_keys", "hackers", column: "id"
  add_foreign_key "profiles", "hackers"
end
