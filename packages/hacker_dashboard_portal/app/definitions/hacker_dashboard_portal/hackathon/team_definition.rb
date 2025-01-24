class HackerDashboardPortal::Hackathon::TeamDefinition < ::Hackathon::TeamDefinition
  include HackerDashboardPortal::ResourceDefinition

  class ShowPage < ShowPage
    def render_breadcrumbs
    end
  end

  class NewPage < NewPage
    def render_breadcrumbs
    end
  end

  new_page_title "Create your team"
  new_page_description "If you would like to join a team instead, ask your team owner to send you an invite."
  edit_page_title "Update team"

  field :role,
    choices: Hackathon::TeamMembership.roles.keys.to_h { |role|
      [role.to_sym, role.titleize]
    },
    hint: "Your role on the team"
end
