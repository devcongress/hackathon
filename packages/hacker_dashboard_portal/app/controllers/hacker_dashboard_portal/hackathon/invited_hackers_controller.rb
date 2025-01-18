class HackerDashboardPortal::Hackathon::InvitedHackersController < ::Hackathon::InvitedHackersController
  include HackerDashboardPortal::Concerns::Controller

  def create
    @invited_hacker = ::Hackathon::InvitedHacker.new(invited_hacker_params)
    authorize_current!(@invited_hacker)
    if @invited_hacker.save
      redirect_to(@invited_hacker, notice: "Invited hacker was successfully created.")
    else
      flash.now[:alert] = "Invited hacker could not be created."
      render(:new)
    end
  end

  private

  def invited_hacker_params
    params
      .expect(hackathon_invited_hacker: [:email])
      .merge({team_id: current_user.team.id})
  end
end
