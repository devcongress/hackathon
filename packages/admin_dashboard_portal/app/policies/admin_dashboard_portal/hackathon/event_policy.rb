class AdminDashboardPortal::Hackathon::EventPolicy < ::Hackathon::EventPolicy
  def publish_event?
    # Only allow publishing draft events
    record.draft?
  end

  def permitted_attributes_for_update
    if record.published?
      [:video_url]
    else
      super
    end
  end

  def permitted_attributes_for_index
    [:title, :event_type, :scheduled_at, :status]
  end
end
