class HackerDashboardPortal::Hackathon::HealthAndSafetyPolicy < ::Hackathon::HealthAndSafetyPolicy
  def new?
    true
  end

  def create?
    user.emergency_contact.nil?
  end
end
