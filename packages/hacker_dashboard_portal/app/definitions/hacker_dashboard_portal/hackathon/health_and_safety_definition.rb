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
          "Double-check to ensure it’s accurate and reachable."

  # TODO: Find a way to override the default styling
  field :consent, as: :checkbox, label: "Consent and Health Declaration",
    hint: @consent_text, required: true

  class NewPage < NewPage
    def render_breadcrumbs
    end
  end

  class ShowPage < ShowPage
    def render_breadcrumbs
    end
  end

  new_page_title "Add Emergency Contact"
  new_page_description "This person will be contacted in case of an emergency"
end
