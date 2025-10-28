class Hackathon::EventDefinition < Hackathon::ResourceDefinition
  field :duration, hint: "Duration in minutes", description: "Duration in minutes"

  display :meeting_link, as: :url
  display :video_url, as: :url

  scope :upcoming
  scope :past
end
