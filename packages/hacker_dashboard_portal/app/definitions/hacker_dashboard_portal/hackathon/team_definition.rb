class HackerDashboardPortal::Hackathon::TeamDefinition < ::Hackathon::TeamDefinition
  include HackerDashboardPortal::ResourceDefinition

  new_page_breadcrumbs false

  new_page_title "Create your team"
  new_page_description "If you would like to join a team instead, ask your team owner to send you an invite."
  edit_page_title "Update team"

  field :role,
    choices: Hackathon::TeamMembership.roles.keys.to_h { |role|
      [role.to_sym, role.titleize]
    },
    hint: "Your role on the team"

  display :name, wrapper: {class: "col-span-2 row-start-1"}
  display :hacker, wrapper: {class: "col-span-2"}
  display :status, wrapper: {class: "col-span-full"}, formatter: ->(value) { value.titleize }

  action :invite_member,
    interaction: Hackathon::Teams::InviteMember

  class ShowPage < ShowPage
    include Phlex::Rails::Helpers::LinkTo

    def render_breadcrumbs
      nav(class: "flex py-3 text-gray-700 mb-2") do
        link_to helpers.root_path, class: "inline-flex items-center text-sm font-medium text-gray-700 hover:text-primary-600 dark:text-gray-200 dark:hover:text-white" do
          svg(class: "w-4 h-4 me-2", fill: "none", stroke: "currentColor", viewbox: "0 0 24 24") do |s|
            s.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M10 19l-7-7m0 0l7-7m-7 7h18")
          end
          plain "Back to Dashboard"
        end
      end
    end
  end

  class EditPage < EditPage
    include NavigatesBackToTeam
  end
end
