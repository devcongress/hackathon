class AddStatusFieldToHackathonTeams < ActiveRecord::Migration[8.0]
  def change
    add_column :hackathon_teams, :status, :integer, null: false, default: 0
  end
end
