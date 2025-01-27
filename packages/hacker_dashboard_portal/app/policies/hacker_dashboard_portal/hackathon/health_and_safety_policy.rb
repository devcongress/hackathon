class HackerDashboardPortal::Hackathon::HealthAndSafetyPolicy < ::Hackathon::HealthAndSafetyPolicy
  def create?
    user.emergency_contact.nil?
  end
end
