class Hackathon::TeamPolicy < Hackathon::ResourcePolicy
  # Core actions

  def create?
    return false if admin?
    return false if hacker? && user.owned_team.present?

    true if hacker? && user.profile.nil?
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

  # Core attributes

  def permitted_attributes_for_create
    [:name]
  end

  def permitted_attributes_for_read
    [:name, :owner]
  end

  # Associations

  def permitted_associations
    if admin? || user.owns_team?(record)
      %i[owner hackers invited_hackers]
    else
      %i[owner hackers]
    end
  end
end
