class AdminDashboardPortal::Hackathon::TeamMembershipPolicy < ::Hackathon::TeamMembershipPolicy
  # Core attributes

  def create?
    false
  end
end
