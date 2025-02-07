module HackerDashboardPortal
  class ProfilePolicy < ::ProfilePolicy
    include HackerDashboardPortal::ResourcePolicy

    def new?
      user.profile.nil?
    end

    def create?
      true
    end

    def update?
      user.profile == record
    end
    def permitted_associations
      %i[emergency_contact] if user.profile == record
    end
  end
end
