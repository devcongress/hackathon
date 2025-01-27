class Hackathon::HealthAndSafetyPolicy < Hackathon::ResourcePolicy
  # Core actions

  def create?
    false
  end

  def read?
    true
  end

  def destroy?
    false
  end

  # Core attributes

  def permitted_attributes_for_create
    [:name, :phone_number, :consent, :hacker]
  end

  def permitted_attributes_for_read
    [:name, :phone_number]
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
