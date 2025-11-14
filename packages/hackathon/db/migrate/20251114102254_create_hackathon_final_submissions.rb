class CreateHackathonFinalSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :hackathon_final_submissions do |t|
      t.references :team, null: false, foreign_key: {to_table: :hackathon_teams}, index: {unique: true}
      t.string :github_repo, null: false
      t.references :peoples_choice_vote, foreign_key: {to_table: :hackathon_teams}, index: {unique: true}, null: false

      t.timestamps
    end
  end
end
