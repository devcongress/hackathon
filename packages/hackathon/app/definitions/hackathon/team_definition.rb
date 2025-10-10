class Hackathon::TeamDefinition < Hackathon::ResourceDefinition
  display :status, formatter: ->(value) { value.titleize }

  field :status, description: "Qualified teams have #{Hackathon::Team::MINIMUM_TEAM_MEMBERSHIPS}+ members, with at least 1 from outside Greater Accra and 1 female member"

  scope :qualified do |scope|
    scope.qualified
  end

  scope :unqualified do |scope|
    scope.unqualified
  end

  scope :late_qualified do |scope|
    scope.late_qualified
  end
end
