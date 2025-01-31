class CreateHackathonCheckIns < ActiveRecord::Migration[8.0]
  def change
    create_table :hackathon_check_ins do |t|
      t.belongs_to :hacker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
