class ResourcePolicy < Plutonium::Resource::Policy
  def create?
    true
  end

  def read?
    true
  end

  def hacker?
    user.instance_of? Hacker
  end

  def admin?
    user.instance_of? Admin
  end
end
