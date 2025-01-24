class HackerDashboardPortal::Hackathon::InvitationsController < ::Hackathon::InvitationsController
  include HackerDashboardPortal::Concerns::Controller

  authorize :team, through: :current_team

  def create
    @invitation = Hackathon::Invitation.new(invitation_params)
    authorize_current! @invitation

    if @invitation.save
      InvitationMailer
        .with(hacker: @invitation)
        .send_invite
        .deliver_later

      redirect_to @invitation.team,
                  notice: "Invitation sent to hacker <#{@invitation.email}>"
    else
      redirect_to hackathon_invitations_path,
                  alert: "The hacker with email <#{invitation_params[:email]}> has been invited already."
    end
  end

  private

    def invitation_params
      params.expect(hackathon_invitation: [ :email ]).merge(team: current_team)
    end

    def current_team
      @current_team ||= current_user.team
    end
end
