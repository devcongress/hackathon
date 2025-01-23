class ProfilePolicy < ::ResourcePolicy
  def create?
    true
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_create
    [ :hacker, :name, :telephone_number ]
  end

  def permitted_attributes_for_read
    %i[hacker name telephone_number]
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
