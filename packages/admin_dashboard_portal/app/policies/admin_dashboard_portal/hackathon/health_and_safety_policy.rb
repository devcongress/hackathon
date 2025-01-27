class AdminDashboardPortal::Hackathon::HealthAndSafetyPolicy < ::Hackathon::HealthAndSafetyPolicy
  # Core attributes

  def permitted_attributes_for_read
    super + [:consented, :hacker]
  end
end
