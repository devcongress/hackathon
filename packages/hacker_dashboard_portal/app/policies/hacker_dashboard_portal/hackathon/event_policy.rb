class HackerDashboardPortal::Hackathon::EventPolicy < ::Hackathon::EventPolicy
  def create?
    false
  end

  def publish?
    false
  end
end
