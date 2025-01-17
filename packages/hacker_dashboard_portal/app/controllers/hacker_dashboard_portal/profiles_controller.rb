class HackerDashboardPortal::ProfilesController < ::ProfilesController
  include HackerDashboardPortal::Concerns::Controller

  skip_before_action :ensure_profile_complete, only: [:new, :create]

  def create
    @profile = ::Profile.new(profile_params.except(:team))
    @team = GlobalID::Locator.locate_signed(profile_params[:team])
    @profile.team = @team

    authorize_current!(@profile)

    if @profile.save
      redirect_to(@profile, notice: "Profile was successfully created.")
    else
      flash.now[:alert] = "Profile could not be created."
      render(:new)
    end
  end

  private

  def profile_params
    params.expect(profile: [:name, :role, :telephone_number, :team]).merge({hacker: current_user})
  end
end
