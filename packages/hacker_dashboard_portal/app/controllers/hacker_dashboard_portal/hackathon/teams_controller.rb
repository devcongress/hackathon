class HackerDashboardPortal::Hackathon::TeamsController < ::Hackathon::TeamsController
  include HackerDashboardPortal::Concerns::Controller

  skip_before_action :ensure_joined_team, only: [:new, :create]

  def present_scoped_entity? = true

  def new
    authorize_current! resource_class

    unless current_user.team.nil?
      redirect_to root_path
      return
    end

    super
  end
end
