class HackerDashboardPortal::Hackathon::TeamMembershipPolicy < ::Hackathon::TeamMembershipPolicy
  # Core attributes

  def new?
    user.team.nil?
  end

  def create?
    true
  end

  def update?
    user == record.hacker
  end

  def destroy?
    false
  end

  def permitted_attributes_for_create
    [:team, :role]
  end

  def permitted_attributes_for_read
    [:hacker, :role]
  end

  relation_scope do |relation|
    next relation unless entity_scope

    relation.where(team: user.team)
  end
end
