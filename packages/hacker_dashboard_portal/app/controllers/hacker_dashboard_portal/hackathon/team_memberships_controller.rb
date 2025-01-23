class HackerDashboardPortal::Hackathon::TeamMembershipsController < ::Hackathon::TeamMembershipsController
  include HackerDashboardPortal::Concerns::Controller

  skip_before_action :ensure_joined_team, only: [ :new, :create ]

  before_action :set_invited_hacker, only: [ :new, :create ]

  def present_scoped_entity? = true

  def new
    flash.now[:notice] =
      "Complete your profile to join the team: #{@invited_hacker.team.name}!"

    super
  end

  def create
    @membership = Hackathon::TeamMembership.new(membership_params)
    authorize_current! @membership

    if @membership.save
      @invited_hacker.update(accepted: true, profile: current_user.profile)
      current_user.update(team: invited_hacker_team)

      InvitationMailer.with(hacker: current_user.profile)
                      .confirm_invite.deliver_later

      if current_user.team.validated?
        TeamMailer.with(team: current_user.team)
                  .validated.deliver_later
      end

      cookies.delete(:invite_token)
      redirect_to hackathon_teams_path,
        notice: "You have successfully joined the team: #{@membership.team.name}!"
    else
      render :new
    end
  end

  private

    def set_invited_hacker
      @invited_hacker ||= ::Hackathon::Invitation.find_by(
        token: cookies.encrypted[:invite_token],
      )
    end

    def set_invitation_team
      @invited_hacker_team ||= @invited_hacker&.team
    end

    def membership_params
      params.expect(hackathon_team_membership: [ :role ]).merge({
        team: invited_hacker_team, hacker: current_user
      })
    end

    def invited_hacker_team
      Hackathon::Invitation.find_by(token: cookies.encrypted[:invite_token])
    end
end
