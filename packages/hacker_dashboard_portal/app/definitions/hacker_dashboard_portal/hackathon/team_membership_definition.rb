class HackerDashboardPortal::Hackathon::TeamMembershipDefinition < ::Hackathon::TeamMembershipDefinition
  include HackerDashboardPortal::ResourceDefinition

  new_page_title -> {
    render_title "Join #{current_parent.name}"
  }
  edit_page_title "Update Membership Role"

  new_page_breadcrumbs false

  class ShowPage < ShowPage
    include Phlex::Rails::Helpers::LinkTo

    def render_breadcrumbs
      nav(class: "flex py-3 text-gray-700 mb-2") do
        link_to resource_url_for(resource_record!.team), class: "inline-flex items-center text-sm font-medium text-gray-700 hover:text-primary-600 dark:text-gray-200 dark:hover:text-white" do
          svg(class: "w-4 h-4 me-2", fill: "none", stroke: "currentColor", viewbox: "0 0 24 24") do |s|
            s.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M10 19l-7-7m0 0l7-7m-7 7h18")
          end
          plain "Back to Team"
        end
      end
    end
  end
end
