class AddSexToProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :sex, :string
  end
end
