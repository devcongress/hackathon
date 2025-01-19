class CreateHackathonTeams < ActiveRecord::Migration[8.0]
  def change
    create_table(:hackathon_teams) do |t|
      t.string(:name, null: false)
      t.belongs_to(
        :hacker,
        null: false,
        foreign_key: { to_table: :hackers },
        index: { unique: true }
      )

      t.timestamps
    end
  end
end
