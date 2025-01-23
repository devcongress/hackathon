class HackerDashboardPortal::Hackathon::TeamMembershipDefinition < ::Hackathon::TeamMembershipDefinition
  include HackerDashboardPortal::ResourceDefinition

  edit_page_title "Update Membership Role"
  new_page_title "Join Team"

  field :team, as: :string, value: "Some Default Read-only Value ",
    readonly: true

  field :role,
    choices: Hackathon::TeamMembership.roles.keys.to_h { |role|
      [role.to_sym, role.titleize]
    },
    hint: "Your role on the team"

  class NewPage < NewPage
    def render_breadcrumbs
    end
  end
end
