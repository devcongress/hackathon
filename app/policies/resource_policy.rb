class ResourcePolicy < Plutonium::Resource::Policy
  def create?
    true
  end

  def read?
    true
  end

  def hacker?
    user.class == Hacker
  end

  def admin?
    user.class == Admin
  end
end
