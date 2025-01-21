class Hackathon::TeamPolicy < Hackathon::ResourcePolicy
  # Core actions

  def create?
    true
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_create
    [:hacker, :name]
  end

  def permitted_attributes_for_read
    [:hacker, :name]
  end

  # Associations

  def permitted_associations
    []
  end
end
