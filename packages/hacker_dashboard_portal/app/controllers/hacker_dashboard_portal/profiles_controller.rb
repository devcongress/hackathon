class HackerDashboardPortal::ProfilesController < ::ProfilesController
  include HackerDashboardPortal::Concerns::Controller

  skip_before_action :ensure_profile_complete, only: [ :new, :create ]
  skip_before_action :ensure_joined_team, only: [ :new, :create ]
end
