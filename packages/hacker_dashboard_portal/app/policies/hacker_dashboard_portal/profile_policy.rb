module HackerDashboardPortal
  class ProfilePolicy < ::ProfilePolicy
    include HackerDashboardPortal::ResourcePolicy

    def index?
      false
    end
  end
end
