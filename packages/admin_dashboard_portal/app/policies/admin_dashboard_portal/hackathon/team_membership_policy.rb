class AdminDashboardPortal::Hackathon::TeamMembershipPolicy < ::Hackathon::TeamMembershipPolicy
  # Core attributes

  def create?
    false
  end

  def permitted_attributes_for_read
    [ :hacker, :role ]
  end
end
