class HackerDashboardPortal::Hackathon::HealthAndSafetyDefinition < ::Hackathon::HealthAndSafetyDefinition
  include HackerDashboardPortal::ResourceDefinition

  @consent_text = <<~TEXT
    By checking this box, I confirm that I am in good health and physically fit
    to participate in this 3-day in-person hackathon. I declare that I have no
    underlying health conditions that would hinder my ability to safely engage in
    this event. I understand that the event organizers are not liable for any
    undisclosed or pre-existing medical conditions that may arise during the hackathon.
  TEXT

  field :name, hint: "Name of the emergency contact."
  field :phone_number, as: :phone,
    hint: "Enter the emergency contact's phone number. " \
          "Double-check to ensure it's accurate and reachable."

  # TODO: Find a way to override the default styling
  field :consent, as: :checkbox, label: "Consent and Health Declaration",
    hint: @consent_text, required: true

  show_page_breadcrumbs false
  new_page_breadcrumbs false

  new_page_title "Add Emergency Contact"
  new_page_description <<~DESC
    By providing this information, you confirm that you are in good health
    and consent to this person being contacted in case of an emergency.
  DESC

  show_page_description "This person will be contacted in case of an emergency"

  class Form < Form
    private

    def render_actions
      input name: "return_to", value: request.params[:return_to], type: :hidden, hidden: true

      actions_wrapper {
        render submit_button
      }
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
