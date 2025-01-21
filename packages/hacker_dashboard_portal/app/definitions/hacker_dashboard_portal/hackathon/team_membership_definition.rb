class HackerDashboardPortal::Hackathon::TeamMembershipDefinition < ::Hackathon::TeamMembershipDefinition
  include HackerDashboardPortal::ResourceDefinition

  edit_page_title "Update Membership Role"

  field :role,
    choices: Hackathon::TeamMembership.roles.keys.to_h { |role|
      [ role.to_sym, role.titleize ]
    },
    hint: "Your role on the team"
end
