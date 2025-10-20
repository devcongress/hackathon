class CreateHackathonProjectSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :hackathon_project_submissions do |t|
      t.references :team, null: false, foreign_key: {to_table: :hackathon_teams}, index: {unique: true}
      t.text :about_project, null: false
      t.text :about_team, null: false

      t.timestamps
    end
  end
end
