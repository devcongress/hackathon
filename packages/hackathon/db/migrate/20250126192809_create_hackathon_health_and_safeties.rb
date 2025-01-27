class CreateHackathonHealthAndSafeties < ActiveRecord::Migration[8.0]
  def change
    create_table :hackathon_health_and_safeties do |t|
      t.string :name, null: false
      t.string :phone_number, null: false
      t.integer :consent, null: false, default: 0
      t.belongs_to :hacker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
