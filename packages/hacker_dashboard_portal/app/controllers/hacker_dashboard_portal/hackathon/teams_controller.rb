class HackerDashboardPortal::Hackathon::TeamsController < ::Hackathon::TeamsController
  include HackerDashboardPortal::Concerns::Controller

  skip_before_action :ensure_joined_team, only: [:new, :create]
  before_action :check_invited_hacker, only: [:new, :create]

  def present_scoped_entity? = true

  private

  # Complete team membership for invited hacker by allowing them select
  # their role in the team.
  def check_invited_hacker
    if cookies.encrypted[:invite_token].present?
      redirect_to(
        resource_url_for(::Hackathon::TeamMembership, action: :new)
      )
    end
  end
end
