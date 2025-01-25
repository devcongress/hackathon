class Hackathon::TeamDefinition < Hackathon::ResourceDefinition
  display :status, formatter: ->(value) { value.titleize }

  scope :qualified do |scope|
    scope.qualified
  end
end
