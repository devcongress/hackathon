class Hackathon::EventDefinition < Hackathon::ResourceDefinition
  display :meeting_link, as: :url
  display :video_url, as: :url

  scope :upcoming
  scope :past
end
