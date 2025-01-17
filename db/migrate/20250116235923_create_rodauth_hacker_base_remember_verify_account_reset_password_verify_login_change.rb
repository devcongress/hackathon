class CreateRodauthHackerBaseRememberVerifyAccountResetPasswordVerifyLoginChange < ActiveRecord::Migration[8.0]
  def change
    create_table(:hackers) do |t|
      t.integer(:status, null: false, default: 1)
      t.string(:email, null: false)
      t.index(:email, unique: true, where: "status IN (1, 2)")
      t.string(:password_hash)
      # t.string(:telephone_number)
      # t.string(:name, null: false)
      # t.references(
      #   :team,
      #   foreign_key: {to_table: :hackathon_teams, index: true, unique: true}
      # )
      # t.string(:role, null: false)
      #
    end

    # Used by the remember me feature
    create_table(:hacker_remember_keys, id: false) do |t|
      t.bigint(:id, primary_key: true)
      t.foreign_key(:hackers, column: :id)
      t.string(:key, null: false)
      t.datetime(:deadline, null: false)
    end

    # Used by the account verification feature
    create_table(:hacker_verification_keys, id: false) do |t|
      t.bigint(:id, primary_key: true)
      t.foreign_key(:hackers, column: :id)
      t.string(:key, null: false)
      t.datetime(:requested_at, null: false, default: -> { "CURRENT_TIMESTAMP" })
      t.datetime(:email_last_sent, null: false, default: -> { "CURRENT_TIMESTAMP" })
    end

    # Used by the password reset feature
    create_table(:hacker_password_reset_keys, id: false) do |t|
      t.bigint(:id, primary_key: true)
      t.foreign_key(:hackers, column: :id)
      t.string(:key, null: false)
      t.datetime(:deadline, null: false)
      t.datetime(:email_last_sent, null: false, default: -> { "CURRENT_TIMESTAMP" })
    end

    # Used by the verify login change feature
    create_table(:hacker_login_change_keys, id: false) do |t|
      t.bigint(:id, primary_key: true)
      t.foreign_key(:hackers, column: :id)
      t.string(:key, null: false)
      t.string(:login, null: false)
      t.datetime(:deadline, null: false)
    end
  end
end
