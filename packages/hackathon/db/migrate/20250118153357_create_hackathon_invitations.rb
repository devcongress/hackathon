class CreateHackathonInvitations < ActiveRecord::Migration[8.0]
  def change
    create_table(:hackathon_invitations) do |t|
      t.string :email, null: false
      t.string :token, null: false
      t.boolean :accepted, null: false, default: false
      t.belongs_to :team, null: false,
        foreign_key: {to_table: :hackathon_teams}
      # email and team_id should be unique together
      t.index [:email, :team_id], unique: true

      t.timestamps
    end
  end
end
