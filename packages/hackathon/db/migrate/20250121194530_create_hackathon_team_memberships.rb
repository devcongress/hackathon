class CreateHackathonTeamMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :hackathon_team_memberships do |t|
      t.belongs_to :hacker, null: false, foreign_key: true, index: {unique: true}
      t.belongs_to :team, null: false, foreign_key: {to_table: :hackathon_teams}
      t.integer :role, null: false

      t.timestamps
    end
  end
end
