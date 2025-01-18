class CreateHackathonInvitedHackers < ActiveRecord::Migration[8.0]
  def change
    create_table(:hackathon_invited_hackers) do |t|
      t.string(:email, null: false, index: {unique: true})
      t.belongs_to(:team, null: false, foreign_key: {:to_table => :hackathon_teams})

      t.timestamps
    end
  end
end
