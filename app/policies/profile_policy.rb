class ProfilePolicy < ::ResourcePolicy
  # Core actions

  def create?
    hacker? && user.profile.nil?
  end

  def read?
    true
  end

  def update?
    hacker? && user.profile == record
  end

  def destroy?
    false
  end

  # Core attributes

  def permitted_attributes_for_create
    [:name, :role, :telephone_number, :team]
  end

  def permitted_attributes_for_read
    [:name, :role, :telephone_number, :team]
  end

  # Associations

  def permitted_associations
    %i[team partners]
  end
end
