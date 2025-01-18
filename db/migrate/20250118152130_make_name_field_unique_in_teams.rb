class MakeNameFieldUniqueInTeams < ActiveRecord::Migration[8.0]
  def change
    change_column(:hackathon_teams, :name, :string, null: false, index: {unique: true})
  end
end
