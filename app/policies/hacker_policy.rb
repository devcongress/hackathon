class HackerPolicy < ::ResourcePolicy
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
    [:email, :status]
  end

  def permitted_attributes_for_read
    [:email, :status]
  end

  # Associations

  def permitted_associations
    %i[profile team]
  end

  private

  def owner?
    user == record
  end
end
