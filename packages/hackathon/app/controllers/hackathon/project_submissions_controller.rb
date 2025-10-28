class Hackathon::ProjectSubmissionsController < Hackathon::ResourceController
  def new
    authorize_current! resource_class

    unless current_user.owns_team?(current_user.team) && current_user.team.project_submission.nil?
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
