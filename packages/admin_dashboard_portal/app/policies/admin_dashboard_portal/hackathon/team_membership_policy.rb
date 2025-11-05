class AdminDashboardPortal::Hackathon::TeamMembershipPolicy < ::Hackathon::TeamMembershipPolicy
  # Core attributes

  def create?
    false
  end

  def destroy?
    # Allow destroying team memberships, but not the team owner's membership
    record.team.hacker_id != record.hacker_id
  end
end
