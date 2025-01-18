class ProfilePolicy < ::ResourcePolicy
  # Core actions

  def new?
    hacker? && user.profile.nil?
  end

  def create?
    true
  end

  def read?
    true
  end

  def update?
    hacker? && user.profile == record
  end

  def destroy?
    update?
  end

  # Core attributes

  def permitted_attributes_for_create
    [:team, :name, :role, :telephone_number]
  end

  def permitted_attributes_for_read
    admin? ? %i[name role telephone_number team] : %i[name role telephone_number]
  end

  # Associations

  def permitted_associations
    %i[team partners]
  end
end
