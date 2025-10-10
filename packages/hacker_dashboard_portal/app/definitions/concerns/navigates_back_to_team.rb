module NavigatesBackToTeam
  extend ActiveSupport::Concern

  private

  def render_breadcrumbs
    nav(class: "flex py-3 text-gray-700 mb-2") do
      link_to resource_url_for(current_user.team), class: "inline-flex items-center text-sm font-medium text-gray-700 hover:text-primary-600 dark:text-gray-200 dark:hover:text-white" do
        svg(class: "w-4 h-4 me-2", fill: "none", stroke: "currentColor", viewbox: "0 0 24 24") do |s|
          s.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M10 19l-7-7m0 0l7-7m-7 7h18")
        end
        plain "Back to Team"
      end
    end
  end
end
