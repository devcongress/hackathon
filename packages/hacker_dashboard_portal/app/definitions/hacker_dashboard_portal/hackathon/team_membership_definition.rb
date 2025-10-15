class HackerDashboardPortal::Hackathon::TeamMembershipDefinition < ::Hackathon::TeamMembershipDefinition
  include HackerDashboardPortal::ResourceDefinition

  new_page_title -> {
    render_title "Join #{current_parent.name}"
  }
  new_page_description "Select your role on the team to complete your invitation"

  edit_page_title "Update Membership Role"

  new_page_breadcrumbs false

  class Form < Form
    private

    def render_actions
      input name: "return_to", value: request.params[:return_to], type: :hidden, hidden: true

      actions_wrapper {
        render submit_button
      }
    end
  end

  class IndexPage < IndexPage
    include NavigatesBackToTeam
  end

  class ShowPage < ShowPage
    include NavigatesBackToTeam
  end

  class EditPage < EditPage
    include NavigatesBackToTeam
  end
end
