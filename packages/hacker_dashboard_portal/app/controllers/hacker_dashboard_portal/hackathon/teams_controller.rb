class HackerDashboardPortal::Hackathon::TeamsController < ::Hackathon::TeamsController
  include HackerDashboardPortal::Concerns::Controller

  skip_before_action :ensure_joined_team, only: [:new, :create]
  before_action :check_invitation, only: [:new, :create]

  def present_scoped_entity? = true

  private

  # Complete team membership for invited hacker by allowing them select
  # their role in the team.
  def check_invitation
    return unless current_invitation

    redirect_to resource_url_for(::Hackathon::TeamMembership, action: :new, parent: current_invitation.team)
  end

  def current_invitation
    return unless cookies.encrypted[:invite_token]

    @invitation ||= ::Hackathon::Invitation.find_by!(token: cookies.encrypted[:invite_token])
  end
end
