class Hackathon::CheckInPolicy < Hackathon::ResourcePolicy
  # Core actions

  def create?
    false
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_create
    [:hacker]
  end

  def permitted_attributes_for_read
    [:hacker, :team, :timestamp]
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
