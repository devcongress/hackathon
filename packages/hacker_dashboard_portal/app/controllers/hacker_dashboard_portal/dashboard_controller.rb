module HackerDashboardPortal
  class DashboardController < PlutoniumController
    def index
      redirect_to resource_url_for(current_user.team) if current_user.team
    end
  end
end
