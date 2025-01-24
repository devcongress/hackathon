class HackerDashboardPortal::Hackathon::TeamPolicy < ::Hackathon::TeamPolicy
  authorize :invitation, allow_nil: true
  # Core actions

  def create?
    user.team.nil?
  end

  def update?
    user.owns_team?(record)
  end

  # Core attributes

  def permitted_attributes_for_create
    super + [:role] - [:hacker]
  end

  def permitted_attributes_for_update
    super - [:role]
  end

  def permitted_attributes_for_read
    super
  end

  def permitted_associations
    if user.owns_team?(record)
      super
    else
      # only team owners should see invitations
      super - [:invitations]
    end
  end

  # show team to only hackers who belong to it
  relation_scope do |relation|
    relation = super(relation)
    if invitation
      relation.or(Hackathon::Team.where(id: invitation.team.id))
    else
      relation
    end
  end
end
