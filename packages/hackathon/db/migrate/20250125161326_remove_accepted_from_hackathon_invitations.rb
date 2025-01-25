class RemoveAcceptedFromHackathonInvitations < ActiveRecord::Migration[8.0]
  def change
    remove_column :hackathon_invitations, :accepted, :boolean
  end
end
