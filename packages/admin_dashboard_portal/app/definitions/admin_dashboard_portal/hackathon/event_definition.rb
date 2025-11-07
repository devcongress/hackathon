class AdminDashboardPortal::Hackathon::EventDefinition < ::Hackathon::EventDefinition
  include AdminDashboardPortal::ResourceDefinition

  action :publish_event,
    interaction: Hackathon::Events::PublishInteraction,
    collection: false

  scope :published
end
