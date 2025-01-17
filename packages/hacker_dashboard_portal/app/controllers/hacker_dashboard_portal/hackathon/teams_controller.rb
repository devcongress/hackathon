class HackerDashboardPortal::Hackathon::TeamsController < ::Hackathon::TeamsController
  include HackerDashboardPortal::Concerns::Controller

  skip_before_action :ensure_profile_complete, only: [:new, :create]

  def create
    @team = ::Hackathon::Team.new(team_params)
    authorize_current!(@team)

    if @team.save
      current_user.team = @team
      current_user.save
      @path = params[:return_to] || @team
      redirect_to(@path, notice: "Team was successfully created.")
    else
      flash.now[:alert] = "Team could not be created."
      render(:new)
    end
  end

  private

  def team_params
    params.expect(hackathon_team: [:name]).merge({hacker_id: current_user.id})
  end
end
