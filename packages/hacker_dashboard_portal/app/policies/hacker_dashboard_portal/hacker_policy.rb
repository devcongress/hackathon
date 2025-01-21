module HackerDashboardPortal
  class HackerPolicy < ::HackerPolicy
    include HackerDashboardPortal::ResourcePolicy

    def permitted_attributes_for_read
      [:email]
    end
  end
end
