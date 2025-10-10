class HackerDashboardPortal::Hackathon::HealthAndSafetiesController < ::Hackathon::HealthAndSafetiesController
  include HackerDashboardPortal::Concerns::Controller

  skip_before_action :ensure_emergency_contact_exists, only: [:new, :create]
  skip_before_action :ensure_joined_team, only: [:new, :create]

  layout :resolve_layout

  def new
    authorize_current! resource_class

    unless current_user.emergency_contact.nil?
      redirect_to root_path
      return
    end

    super
  end

  private

  def resolve_layout
    %w[new create].include?(action_name) ? "onboarding" : "resource"
  end

  def redirect_url_after_submit
    if (return_to = url_from(params[:return_to]))
      return return_to
    end

    if action_name == "create"
      root_path
    else
      super
    end
  end
end
