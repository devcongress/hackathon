class ProfileDefinition < ::ResourceDefinition
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
end
