class Hackathon::TeamMembershipDefinition < Hackathon::ResourceDefinition
  field :role, choices: Hackathon::TeamMembership.roles.keys.to_h { |role|
    [role.to_sym, role.titleize]
  }, hint: "Role on the team"
  display :role, as: :string, formatter: ->(value) { value.titleize }
end
