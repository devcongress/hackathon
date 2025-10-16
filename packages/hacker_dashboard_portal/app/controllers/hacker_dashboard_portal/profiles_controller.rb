class HackerDashboardPortal::ProfilesController < ::ProfilesController
  include HackerDashboardPortal::Concerns::Controller

  skip_before_action :ensure_profile_created, only: [:new, :create]
  skip_before_action :ensure_profile_completed, only: [:edit, :update]
  skip_before_action :ensure_emergency_contact_exists, only: [:new, :create]
  skip_before_action :ensure_joined_team, only: [:new, :create]

  def new
    authorize_current! resource_class

    unless current_user.profile.nil?
      redirect_to root_path
      return
    end

    super
  end

  def show
  end
end
