module HackerDashboardPortal
  class ProfilePolicy < ::ProfilePolicy
    include HackerDashboardPortal::ResourcePolicy

    def new?
      user.profile.nil?
    end
  end
end
