class Hackathon::TeamPolicy < Hackathon::ResourcePolicy
  # Core actions

  def create?
    return false if admin?
    hacker? && user.owned_team.nil? || user.team.nil?
  end

  def show?
    true
  end

  def index?
    admin?
  end

  def update?
    hacker? && user.owns_team?(record)
  end

  def destroy?
    update?
  end

  # Core attributes

  def permitted_attributes_for_create
    [:name]
  end

  def permitted_attributes_for_read
    [:name, :owner]
  end

  # Associations

  def permitted_associations
    %i[owner hackers]
  end
end
