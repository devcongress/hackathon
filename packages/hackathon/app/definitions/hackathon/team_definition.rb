class Hackathon::TeamDefinition < Hackathon::ResourceDefinition
  scope :qualified do |scope|
    scope.qualified
  end
end
