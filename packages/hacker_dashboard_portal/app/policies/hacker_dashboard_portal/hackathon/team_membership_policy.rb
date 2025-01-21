class HackerDashboardPortal::Hackathon::TeamMembershipPolicy < ::Hackathon::TeamMembershipPolicy
  # Core attributes

  def permitted_attributes_for_create
    [:hacker, :role]
  end

  def permitted_attributes_for_read
    [:hacker, :role]
  end
end
