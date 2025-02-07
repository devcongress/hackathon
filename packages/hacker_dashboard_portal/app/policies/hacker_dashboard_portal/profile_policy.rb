module HackerDashboardPortal
  class ProfilePolicy < ::ProfilePolicy
    include HackerDashboardPortal::ResourcePolicy

    def new?
      user.profile.nil?
    end
    def permitted_associations
      %i[emergency_contact] if user.profile == record
    end
  end
end
