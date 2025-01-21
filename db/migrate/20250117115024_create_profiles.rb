class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table(:profiles) do |t|
      t.belongs_to(:hacker, null: false, foreign_key: true, index: {unique: true})
      t.string(:name, null: false)
      t.string(:telephone_number, null: true)

      t.timestamps
    end
  end
end
