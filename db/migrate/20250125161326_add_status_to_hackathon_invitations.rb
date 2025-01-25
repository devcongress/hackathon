class AddStatusToHackathonInvitations < ActiveRecord::Migration[8.0]
  def change
    remove_column :hackathon_invitations, :accepted, :boolean
    add_column :hackathon_invitations, :status, :integer, null: false, default: 0
  end
end
