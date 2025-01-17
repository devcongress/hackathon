class HackerPolicy < ::ResourcePolicy
  # Core actions

  def create?
    false
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_create
    [:email, :status]
  end

  def permitted_attributes_for_read
    [:email, :status, :profile, :team]
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
