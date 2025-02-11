module Hackathon
  class RodauthLayout < ::Plutonium::UI::Layout::RodauthLayout
    def render_content(&)
      link_to root_path,
        class: "flex items-center text-2xl font-semibold text-gray-900 dark:text-white" do
        helpers.resource_logo_tag classname: "w-50 h-24 mr-2"
      end

      div(class: "w-full bg-white rounded-lg shadow dark:border md:mt-0 sm:max-w-md xl:p-0 dark:bg-gray-800 dark:border-gray-700") {
        div(class: "p-6 space-y-4 md:space-y-6 sm:p-8", &)
      }

      div(
        class: "mt-4 flex items-center font-medium text-secondary-600 dark:text-secondary-400 hover:underline"
      ) {
        render Phlex::TablerIcons::Home2.new
        link_to "Home", root_path, class: "font-medium text-secondary-600 dark:text-secondary-400"
      }
    end
  end
end
