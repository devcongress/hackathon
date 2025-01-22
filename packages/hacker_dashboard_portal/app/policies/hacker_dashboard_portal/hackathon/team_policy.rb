class HackerDashboardPortal::Hackathon::TeamPolicy < ::Hackathon::TeamPolicy
  # Core actions

  def create?
    user.team.nil?
  end

  def update?
    user.owns_team?(record)
  end

  # Core attributes

  def permitted_attributes_for_create
    super + [ :role ] - [ :hacker ]
  end

  def permitted_attributes_for_update
    super - [ :role ]
  end

  def permitted_attributes_for_read
    [ :name, :hacker ]
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
