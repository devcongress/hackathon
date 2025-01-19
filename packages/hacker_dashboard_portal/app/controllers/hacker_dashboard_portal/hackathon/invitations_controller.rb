class HackerDashboardPortal::Hackathon::InvitationsController < ::Hackathon::InvitationsController
  include HackerDashboardPortal::Concerns::Controller

  def create
    @invited_hacker = ::Hackathon::Invitation.new(invitation_params)
    @invited_hacker.token = SecureRandom.urlsafe_base64(64)

    authorize_current! @invited_hacker

    if @invited_hacker.save
      InvitationMailer
        .with(hacker: @invited_hacker)
        .send_invite
        .deliver_later!

      redirect_to @invited_hacker,
                  notice: "Invitation sent to hacker <#{@invited_hacker.email}>"
    else
      redirect_to hackathon_invitations_path,
                  alert: "The hacker with email <#{invitation_arams[:email]}> has been invited already."
    end
  end

  private

    def invitation_params
      params
        .expect(hackathon_invitation: [ :email ])
        .merge({ team_id: current_user.team.id })
    end
end
