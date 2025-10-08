class ProfilePolicy < ::ResourcePolicy
  def create?
    false
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_create
    [:hacker, :name, :telephone_number, :region, :skillsets]
  end

  def permitted_attributes_for_read
    %i[hacker name telephone_number region skillsets]
  end

  # Associations

  def permitted_associations
    %i[emergency_contact]
  end
end
