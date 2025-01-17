class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table(:profiles) do |t|
      t.string(:name, null: false)
      t.string(:role, null: false)
      t.string(:telephone_number, null: true)
      t.belongs_to(:team, null: false, foreign_key: {:to_table => :hackathon_teams})
      t.belongs_to(:hacker, null: false, foreign_key: true)

      # # helps to track the partners for the hacker
      # t.references(:profiles, :partner, foreign_key: {to_table: :profiles})
      t.timestamps
    end

    add_reference(:profiles, :partner, foreign_key: {to_table: :profiles})
  end
end
