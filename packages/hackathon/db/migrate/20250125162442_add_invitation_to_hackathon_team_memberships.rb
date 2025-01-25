class AddInvitationToHackathonTeamMemberships < ActiveRecord::Migration[8.0]
  def change
    add_reference :hackathon_team_memberships, :invitation, null: true, foreign_key: {to_table: :hackathon_invitations}
  end
end
