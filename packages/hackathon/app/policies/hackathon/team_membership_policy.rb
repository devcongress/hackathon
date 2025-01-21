class Hackathon::TeamMembershipPolicy < Hackathon::ResourcePolicy
  # Core actions

  def create?
    true
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_create
    [:hacker, :team, :role]
  end

  def permitted_attributes_for_read
    [:hacker, :team, :role]
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
