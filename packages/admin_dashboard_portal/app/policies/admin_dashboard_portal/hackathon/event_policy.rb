class AdminDashboardPortal::Hackathon::EventPolicy < ::Hackathon::EventPolicy
  def update?
    record.draft?
  end

  def publish_event?
    # Only allow publishing draft events
    record.draft?
  end
end
