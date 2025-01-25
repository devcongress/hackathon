class Hackathon::InvitationPolicy < Hackathon::ResourcePolicy
  # Core actions

  def create?
    false
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_create
    [:email]
  end

  def permitted_attributes_for_read
    [:email, :status, :team]
  end

  # Associations

  def permitted_associations
    %i[team_membership]
  end
end
