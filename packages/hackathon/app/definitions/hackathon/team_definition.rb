class Hackathon::TeamDefinition < Hackathon::ResourceDefinition
  display :status, formatter: ->(value) { value.titleize }

  field :status, description: "3 members are required to qualify"

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
