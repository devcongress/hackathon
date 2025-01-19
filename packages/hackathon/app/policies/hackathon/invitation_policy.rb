class Hackathon::InvitationPolicy < Hackathon::ResourcePolicy
  # Core actions

  def create?
    hacker? && user.owned_team.present?
  end

  def read?
    true
  end

  def index?
    admin? || hacker? && user.owned_team.present?
  end

  # Core attributes

  def permitted_attributes_for_create
    [ :email ]
  end

  def permitted_attributes_for_read
    [ :email ]
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
