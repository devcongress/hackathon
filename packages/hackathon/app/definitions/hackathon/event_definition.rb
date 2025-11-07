class Hackathon::EventDefinition < Hackathon::ResourceDefinition
  field :duration, hint: "Duration in minutes", description: "Duration in minutes"

  display :meeting_link, as: :url
  display :video_url, as: :url

  scope :upcoming
  scope :past

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
