class Hackathon::TeamPolicy < Hackathon::ResourcePolicy
  # Core actions

  def create?
    false
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_create
    [:hacker, :name]
  end

  def permitted_attributes_for_read
    [:hacker, :name, :validated]
  end

  # Associations

  def permitted_associations
    %i[team_memberships invitations]
  end
end
