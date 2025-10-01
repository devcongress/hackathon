class Hackathon::HealthAndSafetyDefinition < Hackathon::ResourceDefinition
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
end
