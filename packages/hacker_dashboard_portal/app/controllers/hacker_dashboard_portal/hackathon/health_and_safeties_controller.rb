class HackerDashboardPortal::Hackathon::HealthAndSafetiesController < ::Hackathon::HealthAndSafetiesController
  include HackerDashboardPortal::Concerns::Controller

  skip_before_action :ensure_emergency_contact_exists, only: [:new, :create]
  skip_before_action :ensure_joined_team, only: [:new, :create]
end
