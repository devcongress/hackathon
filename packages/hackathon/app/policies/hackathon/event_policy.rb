class Hackathon::EventPolicy < Hackathon::ResourcePolicy
  # Core actions

  def create?
    true
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_create
    [:title, :description, :event_type, :scheduled_at, :duration, :meeting_link, :video_url]
  end

  def permitted_attributes_for_read
    [:title, :description, :event_type, :scheduled_at, :duration, :meeting_link, :video_url, :status]
  end

  def permitted_attributes_for_index
    [:title, :event_type, :scheduled_at, :status]
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
