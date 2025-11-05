class AdminDashboardPortal::Hackathon::EventDefinition < ::Hackathon::EventDefinition
  include AdminDashboardPortal::ResourceDefinition

  action :publish_event,
    interaction: Hackathon::Events::PublishInteraction,
    collection: false

  scope :published

  # Make each field take full row (vertical layout)
  display :title, wrapper: {class: "col-span-full"}
  display :description, wrapper: {class: "col-span-full"}
  display :event_type, wrapper: {class: "col-span-full"}
  display :scheduled_at, wrapper: {class: "col-span-full"}
  display :duration, wrapper: {class: "col-span-full"}
  display :meeting_link, wrapper: {class: "col-span-full"}
  display :video_url, wrapper: {class: "col-span-full"}
  display :status, wrapper: {class: "col-span-full"}
end
