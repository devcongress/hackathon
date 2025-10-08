class AddSkillsetsAndRegionToProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :skillsets, :text
    add_column :profiles, :region, :string
  end
end
