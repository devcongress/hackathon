class HackerDashboardPortal::ProfileDefinition < ::ProfileDefinition
  include HackerDashboardPortal::ResourceDefinition

  new_page_breadcrumbs false

  new_page_title "Complete Your Profile"
  show_page_title "Profile"

  edit_page_title "Edit Your Profile"
  index_page_title "Team Members"

  class Form < Form
    private

    def render_actions
      input name: "return_to", value: request.params[:return_to], type: :hidden, hidden: true

      actions_wrapper {
        render submit_button
      }
    end
  end

  class EditPage < EditPage
    include Phlex::Rails::Helpers::LinkTo

    def render_breadcrumbs
      nav(class: "flex py-3 text-gray-700 mb-2") do
        link_to resource_url_for(resource_record!), class: "inline-flex items-center text-sm font-medium text-gray-700 hover:text-primary-600 dark:text-gray-200 dark:hover:text-white" do
          svg(class: "w-4 h-4 me-2", fill: "none", stroke: "currentColor", viewbox: "0 0 24 24") do |s|
            s.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M10 19l-7-7m0 0l7-7m-7 7h18")
          end
          plain "Back to Profile"
        end
      end
    end
  end

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
end
