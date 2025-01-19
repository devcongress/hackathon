class HackerPolicy < ::ResourcePolicy
  # Core actions

  def create?
    false
  end

  def read?
    true
  end

  def destroy?
    owner?
  end

  # Core attributes

  def permitted_attributes_for_create
    [ :email, :status ]
  end

  def permitted_attributes_for_read
    if admin?
      [ :email, :profile, :team ]
    else
      [ :email, :profile ]
    end
  end

  # Associations

  def permitted_associations
    %i[]
  end

  private

    def owner?
      user == record
    end
end
