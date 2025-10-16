class HackerDashboardPortal::Hackathon::TeamMembershipPolicy < ::Hackathon::TeamMembershipPolicy
  authorize :invitation, allow_nil: true
  # Core attributes

  def new?
    true
  end

  def create?
    user.team.nil?
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
    relation = super(relation)
    if invitation && user.team.nil?
      relation.or(Hackathon::Team.where(id: invitation.team.id))
    else
      relation
    end
  end
end
