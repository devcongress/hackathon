class HackerDashboardPortal::Hackathon::FinalSubmissionsController < ::Hackathon::FinalSubmissionsController
  include HackerDashboardPortal::Concerns::Controller

  def new
    authorize_current! resource_class

    unless current_user.team&.invited? && current_user.owns_team?(current_user.team) && current_user.team.final_submission.nil?
      redirect_to root_path
      return
    end

    super
  end

  private

  def resource_params
    super.merge(team: current_user.team)
  end
end
