class HackerDashboardPortal::ProfilesController < ::ProfilesController
  include HackerDashboardPortal::Concerns::Controller

  skip_before_action :ensure_profile_complete, only: [:new, :create]
  skip_before_action :ensure_emergency_contact_exists, only: [:new, :create]
  skip_before_action :ensure_joined_team, only: [:new, :create]

  layout :resolve_layout

  def new
    if resource_record?
      redirect_to root_path
      return
    end

    super
  end

  private

  def resolve_layout
    (action_name == "new") ? "onboarding" : "resource"
  end
end
