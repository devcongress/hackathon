class AdminDashboardPortal::Hackathon::HealthAndSafetyPolicy < ::Hackathon::HealthAndSafetyPolicy
  # Core attributes

  def permitted_attributes_for_read
    super + [:consent, :hacker]
  end
end
