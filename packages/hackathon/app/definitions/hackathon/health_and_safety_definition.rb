class Hackathon::HealthAndSafetyDefinition < Hackathon::ResourceDefinition
  show_page_description "This person will be contacted in case of an emergency"

  display :consent, formatter: ->(value) {
    (value == "yes") ? "Accepted" : "Not accepted"
  }
end
