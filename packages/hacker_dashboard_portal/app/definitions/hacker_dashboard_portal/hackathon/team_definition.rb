class HackerDashboardPortal::Hackathon::TeamDefinition < ::Hackathon::TeamDefinition
  include HackerDashboardPortal::ResourceDefinition

  show_page_breadcrumbs false
  new_page_breadcrumbs false

  new_page_title "Create your team"
  new_page_description "If you would like to join a team instead, ask your team owner to send you an invite."
  edit_page_title "Update team"

  field :role,
    choices: Hackathon::TeamMembership.roles.keys.to_h { |role|
      [role.to_sym, role.titleize]
    },
    hint: "Your role on the team"

  display :name, wrapper: {class: "col-span-full row-start-1"}

  action :invite_member,
    interaction: Hackathon::Teams::InviteMember
end
