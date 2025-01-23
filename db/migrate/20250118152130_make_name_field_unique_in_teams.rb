class MakeNameFieldUniqueInTeams < ActiveRecord::Migration[8.0]
  def change
    remove_index :hackathon_teams, :name if index_exists?(:hackathon_teams,
      :name)
    add_index :hackathon_teams, "LOWER(name)", unique: true
  end
end
