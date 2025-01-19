class CreateAccountIdentities < ActiveRecord::Migration[8.0]
  def change
    create_table(:account_identities) do |t|
      t.belongs_to(:account, null: false, foreign_key: { to_table: :hackers })
      t.string(:provider)
      t.string(:uid)
    end

    add_index(:account_identities, :provider)
    add_index(:account_identities, :uid)
  end
end
