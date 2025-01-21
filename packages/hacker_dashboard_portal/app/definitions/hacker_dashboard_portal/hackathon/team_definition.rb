class HackerDashboardPortal::Hackathon::TeamDefinition < ::Hackathon::TeamDefinition
  include HackerDashboardPortal::ResourceDefinition

  new_page_title "Create your team"

  field :role,
    choices: Hackathon::TeamMembership.roles.keys.to_h { |role| [role.to_sym, role.titleize] },
    hint: "Your role on the team"
end
