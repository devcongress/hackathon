class Hackathon::TeamDefinition < Hackathon::ResourceDefinition
  scope :validated do |scope|
    scope.with_minimum_memberships
  end
end
